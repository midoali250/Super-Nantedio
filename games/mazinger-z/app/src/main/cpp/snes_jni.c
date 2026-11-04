/*
 * Minimal libretro frontend for Snes9x 2010, driven from Android through JNI.
 *
 * The ROM is fed to retro_load_game() from memory, video is delivered as
 * RGB565 into a private buffer and audio is queued in a ring buffer that the
 * Java side drains into an AudioTrack.
 *
 * The SNES joypad has four face buttons (A, B, X, Y) plus L/R shoulders,
 * so the input mask uses the full libretro RETRO_DEVICE_ID_JOYPAD_* range.
 */
#include <jni.h>
#include <stdarg.h>

#ifdef __ANDROID__
#include <android/log.h>
#endif
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "libretro.h"

#define FB_MAX_W 512
#define FB_MAX_H 512
#define AUDIO_RING_FRAMES 16384

static uint8_t  *g_rom;
static size_t    g_rom_len;
static uint16_t  g_fb[FB_MAX_W * FB_MAX_H];
static int       g_fb_w, g_fb_h, g_fb_pitch_px;
static int       g_have_frame;

static int16_t   g_audio[AUDIO_RING_FRAMES * 2];
static volatile int g_audio_head, g_audio_tail;   /* in stereo frames */

static unsigned  g_mask;          /* joypad bitmask, libretro button ids */

static char g_save_dir[512];
static char g_content_path[600];
static char g_sram_path[600];

static void core_log(enum retro_log_level level, const char *fmt, ...)
{
   char line[1024];
   va_list args;
   (void)level;
   va_start(args, fmt);
   vsnprintf(line, sizeof(line), fmt, args);
   va_end(args);
#ifdef __ANDROID__
   __android_log_print(ANDROID_LOG_INFO, "snescore", "%s", line);
#else
   fputs(line, stderr);
#endif
}

static struct retro_log_callback g_log = { core_log };

static void ring_push(const int16_t *data, size_t frames)
{
   size_t i;
   for (i = 0; i < frames; i++)
   {
      int next = (g_audio_head + 1) % AUDIO_RING_FRAMES;
      if (next == g_audio_tail)
         g_audio_tail = (g_audio_tail + 1) % AUDIO_RING_FRAMES;  /* drop oldest */
      g_audio[g_audio_head * 2 + 0] = data[i * 2 + 0];
      g_audio[g_audio_head * 2 + 1] = data[i * 2 + 1];
      g_audio_head = next;
   }
}

static size_t ring_pop(int16_t *out, size_t max_frames)
{
   size_t n = 0;
   while (n < max_frames && g_audio_tail != g_audio_head)
   {
      out[n * 2 + 0] = g_audio[g_audio_tail * 2 + 0];
      out[n * 2 + 1] = g_audio[g_audio_tail * 2 + 1];
      g_audio_tail = (g_audio_tail + 1) % AUDIO_RING_FRAMES;
      n++;
   }
   return n;
}

/* Core options the app pins. Everything else is left to the core default. */
static const char *option_value(const char *key)
{
   if (!strcmp(key, "snes9x_2010_region"))              return "ntsc";
   if (!strcmp(key, "snes9x_2010_audio_interpolation")) return "gaussian";
   if (!strcmp(key, "snes9x_2010_aspect"))              return "4:3";
   if (!strcmp(key, "snes9x_2010_frameskip"))           return "none";
   if (!strcmp(key, "snes9x_2010_reduce_sprite_flicker")) return "disabled";
   return NULL;
}

static bool env_cb(unsigned cmd, void *data)
{
   switch (cmd)
   {
      case RETRO_ENVIRONMENT_SET_PIXEL_FORMAT:
      {
         const enum retro_pixel_format *fmt = (const enum retro_pixel_format *)data;
         return *fmt == RETRO_PIXEL_FORMAT_RGB565;
      }
      case RETRO_ENVIRONMENT_GET_CAN_DUPE:
         *(bool *)data = true;
         return true;
      case RETRO_ENVIRONMENT_GET_VARIABLE:
      {
         struct retro_variable *var = (struct retro_variable *)data;
         const char *v = var->key ? option_value(var->key) : NULL;
         var->value = v;
         return v != NULL;
      }
      case RETRO_ENVIRONMENT_GET_VARIABLE_UPDATE:
         *(bool *)data = false;
         return true;
      case RETRO_ENVIRONMENT_GET_LOG_INTERFACE:
         *(struct retro_log_callback *)data = g_log;
         return true;
      case RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY:
      {
         /* The core asks for this to find an optional BIOS file. Point it at
          * the app's private files directory so a user-supplied BIOS (if any)
          * can be found next to the SRAM files. */
         const char *dir = g_save_dir[0] ? g_save_dir : ".";
         *(const char **)data = dir;
         return true;
      }
      case RETRO_ENVIRONMENT_SET_VARIABLES:
      case RETRO_ENVIRONMENT_SET_INPUT_DESCRIPTORS:
      case RETRO_ENVIRONMENT_SET_CONTROLLER_INFO:
      case RETRO_ENVIRONMENT_SET_SUPPORT_NO_GAME:
      case RETRO_ENVIRONMENT_SET_PERFORMANCE_LEVEL:
      case RETRO_ENVIRONMENT_SET_MEMORY_MAPS:
      case RETRO_ENVIRONMENT_SET_GEOMETRY:
      case RETRO_ENVIRONMENT_SET_SYSTEM_AV_INFO:
      case RETRO_ENVIRONMENT_SET_MESSAGE:
      case RETRO_ENVIRONMENT_SET_SUPPORT_ACHIEVEMENTS:
      case RETRO_ENVIRONMENT_SET_SERIALIZATION_QUIRKS:
         return true;
      case RETRO_ENVIRONMENT_GET_INPUT_BITMASKS:
         return false;              /* we answer per-button */
      case RETRO_ENVIRONMENT_GET_LANGUAGE:
         *(unsigned *)data = RETRO_LANGUAGE_ENGLISH;
         return true;
      case RETRO_ENVIRONMENT_GET_AUDIO_VIDEO_ENABLE:
         *(int *)data = 3;          /* video + audio enabled */
         return true;
      default:
         return false;
   }
}

static void video_cb(const void *data, unsigned width, unsigned height, size_t pitch)
{
   int y;
   if (!data)
   {
      g_have_frame = 1;
      return;
   }
   if ((int)width > FB_MAX_W || (int)height > FB_MAX_H)
      return;
   g_fb_w = (int)width;
   g_fb_h = (int)height;
   g_fb_pitch_px = (int)(pitch / 2);
   for (y = 0; y < (int)height; y++)
      memcpy(g_fb + y * width, (const uint8_t *)data + y * pitch, width * 2);
   g_have_frame = 1;
}

static size_t audio_cb(const int16_t *data, size_t frames)
{
   ring_push(data, frames);
   return frames;
}

static void audio_sample_cb(int16_t left, int16_t right)
{
   int16_t frame[2];
   frame[0] = left;
   frame[1] = right;
   ring_push(frame, 1);
}

static void input_poll_cb(void) { }

static int16_t input_state_cb(unsigned port, unsigned device, unsigned index, unsigned id)
{
   (void)index;
   if (port == 0 && device == RETRO_DEVICE_JOYPAD)
   {
      if (id == RETRO_DEVICE_ID_JOYPAD_MASK)
         return (int16_t)g_mask;
      return (g_mask >> id) & 1;
   }
   return 0;
}

/* ---------------------------------------------------------------------------
 * Battery-backed SRAM
 *
 * The core exposes the cart's save RAM through RETRO_MEMORY_SAVE_RAM; the
 * frontend owns the file, exactly as the libretro contract requires.
 * ------------------------------------------------------------------------- */
static void sram_load(void)
{
   FILE *f;
   void *ram;
   size_t size;
   if (!g_sram_path[0])
      return;
   ram = retro_get_memory_data(RETRO_MEMORY_SAVE_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SAVE_RAM);
   if (!ram || size == 0)
      return;
   f = fopen(g_sram_path, "rb");
   if (!f)
      return;
   if (fread(ram, 1, size, f) != size)
      core_log(RETRO_LOG_WARN, "SRAM file is short, ignoring it\n");
   fclose(f);
}

static void sram_save(void)
{
   FILE *f;
   void *ram;
   size_t size;
   if (!g_sram_path[0])
      return;
   ram = retro_get_memory_data(RETRO_MEMORY_SAVE_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SAVE_RAM);
   if (!ram || size == 0)
      return;
   f = fopen(g_sram_path, "wb");
   if (!f)
      return;
   fwrite(ram, 1, size, f);
   fclose(f);
}

JNIEXPORT jboolean JNICALL
Java_com_midoali_snes_SnesCore_nativeStart(JNIEnv *env, jclass cls,
                                           jbyteArray rom, jstring saveDir)
{
   struct retro_game_info game;
   const char *dir = ".";
   (void)cls;

   memset(&game, 0, sizeof(game));
   g_rom_len = (size_t)(*env)->GetArrayLength(env, rom);
   g_rom = (uint8_t *)malloc(g_rom_len);
   if (!g_rom)
      return JNI_FALSE;
   (*env)->GetByteArrayRegion(env, rom, 0, (jsize)g_rom_len, (jbyte *)g_rom);

   if (saveDir)
   {
      const char *s = (*env)->GetStringUTFChars(env, saveDir, NULL);
      if (s)
      {
         snprintf(g_save_dir, sizeof(g_save_dir), "%s", s);
         dir = g_save_dir;
         (*env)->ReleaseStringUTFChars(env, saveDir, s);
      }
   }

   g_audio_head = g_audio_tail = 0;

   /* Snes9x wants a content path for the cartridge name (it derives the
    * save file name from it), so mirror the ROM into the app's files
    * directory and hand that path over together with the bytes. */
   snprintf(g_content_path, sizeof(g_content_path), "%s/mazingerz.smc", dir);
   {
      FILE *f = fopen(g_content_path, "wb");
      if (f)
      {
         fwrite(g_rom, 1, g_rom_len, f);
         fclose(f);
      }
   }
   snprintf(g_sram_path, sizeof(g_sram_path), "%s/mazingerz.srm", dir);

   retro_set_environment(env_cb);
   retro_set_video_refresh(video_cb);
   retro_set_audio_sample(audio_sample_cb);
   retro_set_audio_sample_batch(audio_cb);
   retro_set_input_poll(input_poll_cb);
   retro_set_input_state(input_state_cb);

   retro_init();

   game.path = g_content_path;
   game.data = g_rom;
   game.size = g_rom_len;
   game.meta = NULL;
   if (!retro_load_game(&game))
      return JNI_FALSE;

   /* Player 1: standard SNES pad. */
   retro_set_controller_port_device(0, RETRO_DEVICE_JOYPAD);

   sram_load();

   retro_run();          /* first frame also finalises AV info */
   return JNI_TRUE;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeStop(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   sram_save();
   retro_unload_game();
   retro_deinit();
   free(g_rom);
   g_rom = NULL;
   g_rom_len = 0;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeRunFrame(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   g_have_frame = 0;
   retro_run();
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeFrameWidth(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return g_fb_w;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeFrameHeight(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return g_fb_h;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeCopyVideo(JNIEnv *env, jclass cls, jobject buffer)
{
   void *dst = (*env)->GetDirectBufferAddress(env, buffer);
   jlong cap = (*env)->GetDirectBufferCapacity(env, buffer);
   size_t need = (size_t)g_fb_w * (size_t)g_fb_h * 2;
   (void)cls;
   if (!dst || cap < (jlong)need || !g_have_frame)
      return 0;
   memcpy(dst, g_fb, need);
   return 1;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetInput(JNIEnv *env, jclass cls, jint mask)
{
   (void)env; (void)cls;
   g_mask = (unsigned)mask;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeReadAudio(JNIEnv *env, jclass cls,
                                               jshortArray out, jint maxFrames)
{
   jsize len = (*env)->GetArrayLength(env, out);
   int16_t *tmp;
   size_t n;
   (void)cls;
   if (maxFrames <= 0 || len < maxFrames * 2)
      maxFrames = len / 2;
   tmp = (int16_t *)malloc((size_t)maxFrames * 2 * sizeof(int16_t));
   if (!tmp)
      return 0;
   n = ring_pop(tmp, (size_t)maxFrames);
   if (n)
      (*env)->SetShortArrayRegion(env, out, 0, (jsize)(n * 2), (jshort *)tmp);
   free(tmp);
   return (jint)n;
}

JNIEXPORT jdouble JNICALL
Java_com_midoali_snes_SnesCore_nativeFps(JNIEnv *env, jclass cls)
{
   struct retro_system_av_info av;
   (void)env; (void)cls;
   retro_get_system_av_info(&av);
   return av.timing.fps > 1.0 ? av.timing.fps : 60.0988;
}

JNIEXPORT jdouble JNICALL
Java_com_midoali_snes_SnesCore_nativeSampleRate(JNIEnv *env, jclass cls)
{
   struct retro_system_av_info av;
   (void)env; (void)cls;
   retro_get_system_av_info(&av);
   return av.timing.sample_rate > 1.0 ? av.timing.sample_rate : 44100.0;
}

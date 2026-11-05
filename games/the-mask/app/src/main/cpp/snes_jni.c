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

#define SRC_MAX_W 512
#define SRC_MAX_H 256
#define FB_MAX_W  1024
#define FB_MAX_H  512
#define AUDIO_RING_FRAMES 16384

/* Built-in cheat bitmask for The Mask (USA) [SNES] */
#define CHEAT_INF_HEALTH      (1u << 0)
#define CHEAT_INF_MASK_POWER  (1u << 1)
#define CHEAT_INF_LIVES       (1u << 2)
#define CHEAT_INVINCIBLE      (1u << 3)
#define CHEAT_MOON_JUMP       (1u << 4)
#define CHEAT_LEVEL_SELECT    (1u << 5)

static uint8_t  *g_rom;
static size_t    g_rom_len;
static uint16_t  g_dedith[SRC_MAX_W * SRC_MAX_H];
static uint16_t  g_fb[FB_MAX_W * FB_MAX_H];
static uint16_t  g_color_lut[65536];
static int       g_lut_ready;
static int       g_fb_w, g_fb_h, g_fb_pitch_px;
static int       g_have_frame;

static int16_t   g_audio[AUDIO_RING_FRAMES * 2];
static volatile int g_audio_head, g_audio_tail;   /* in stereo frames */

static unsigned  g_mask;          /* joypad bitmask, libretro button ids */
static unsigned  g_cheats;        /* active cheat bitmask */
static int       g_initialised;   /* retro_init() has run */
static int       g_loaded;        /* a game is loaded and needs unloading */

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

static inline uint16_t rgb565_avg(uint16_t a, uint16_t b)
{
   return (uint16_t)((a & b) + (((a ^ b) & 0xF7DEu) >> 1));
}

static inline uint16_t rgb565_mix31(uint16_t a, uint16_t b)
{
   return rgb565_avg(a, rgb565_avg(a, b));
}

static inline int rgb565_diff(uint16_t a, uint16_t b)
{
   int dr, dg, db;
   if (a == b)
      return 0;
   dr = (int)((a >> 11) & 0x1F) - (int)((b >> 11) & 0x1F);
   dg = (int)((a >> 6)  & 0x1F) - (int)((b >> 6)  & 0x1F);
   db = (int)(a & 0x1F)         - (int)(b & 0x1F);
   if (dr < 0) dr = -dr;
   if (dg < 0) dg = -dg;
   if (db < 0) db = -db;
   return dr + dg + db;
}

static void init_hd_color_lut(void)
{
   int v;
   if (g_lut_ready)
      return;
   for (v = 0; v < 65536; v++)
   {
      int r5 = (v >> 11) & 0x1F;
      int g6 = (v >> 5)  & 0x3F;
      int b5 = v & 0x1F;
      int r = (r5 << 3) | (r5 >> 2);
      int g = (g6 << 2) | (g6 >> 4);
      int b = (b5 << 3) | (b5 >> 2);
      int luma = (r * 77 + g * 150 + b * 29) >> 8;
      r = luma + (((r - luma) * 276) >> 8);
      g = luma + (((g - luma) * 276) >> 8);
      b = luma + (((b - luma) * 276) >> 8);
      if (r < 0) r = 0; else if (r > 255) r = 255;
      if (g < 0) g = 0; else if (g > 255) g = 255;
      if (b < 0) b = 0; else if (b > 255) b = 255;
      g_color_lut[v] = (uint16_t)(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3));
   }
   g_lut_ready = 1;
}

static void video_cb(const void *data, unsigned width, unsigned height, size_t pitch)
{
   int w = (int)width;
   int h = (int)height;
   int x, y;
   if (!data)
   {
      g_have_frame = 1;
      return;
   }
   if (w <= 0 || h <= 0 || w > SRC_MAX_W || h > SRC_MAX_H)
      return;
   init_hd_color_lut();

   for (y = 0; y < h; y++)
   {
      const uint16_t *src_row = (const uint16_t *)((const uint8_t *)data + y * pitch);
      uint16_t *dst_row = g_dedith + y * w;
      for (x = 0; x < w; x++)
         dst_row[x] = g_color_lut[src_row[x]];
   }

   g_fb_w = w * 2;
   g_fb_h = h * 2;
   g_fb_pitch_px = g_fb_w;

   for (y = 0; y < h; y++)
   {
      int ym1 = (y > 0) ? (y - 1) : 0;
      int yp1 = (y + 1 < h) ? (y + 1) : (h - 1);
      const uint16_t *rowA = g_dedith + ym1 * w;
      const uint16_t *rowP = g_dedith + y * w;
      const uint16_t *rowD = g_dedith + yp1 * w;
      uint16_t *out0 = g_fb + (y * 2) * g_fb_w;
      uint16_t *out1 = g_fb + (y * 2 + 1) * g_fb_w;

      for (x = 0; x < w; x++)
      {
         int xm1 = (x > 0) ? (x - 1) : 0;
         int xp1 = (x + 1 < w) ? (x + 1) : (w - 1);
         uint16_t P = rowP[x];
         uint16_t A = rowA[x];
         uint16_t B = rowP[xp1];
         uint16_t C = rowP[xm1];
         uint16_t D = rowD[x];
         uint16_t UL, UR, DL, DR;
         uint16_t e0, e1, e2, e3;

         if (P == A && P == B && P == C && P == D)
         {
            out0[x * 2]     = P;
            out0[x * 2 + 1] = P;
            out1[x * 2]     = P;
            out1[x * 2 + 1] = P;
            continue;
         }

         UL = rowA[xm1];
         UR = rowA[xp1];
         DL = rowD[xm1];
         DR = rowD[xp1];
         e0 = P; e1 = P; e2 = P; e3 = P;

         if (C != B && A != D)
         {
            int ca = (C == A || rgb565_diff(C, A) < 8);
            int ab = (A == B || rgb565_diff(A, B) < 8);
            int dc = (D == C || rgb565_diff(D, C) < 8);
            int bd = (B == D || rgb565_diff(B, D) < 8);

            if (ca && !ab && !dc)
            {
               uint16_t m = rgb565_avg(C, A);
               e0 = (P == B || P == D) ? rgb565_mix31(m, P) : rgb565_avg(P, m);
               if (A == UR && P != UR) e1 = rgb565_mix31(P, m);
               if (C == DL && P != DL) e2 = rgb565_mix31(P, m);
            }
            if (ab && !ca && !bd)
            {
               uint16_t m = rgb565_avg(A, B);
               e1 = (P == C || P == D) ? rgb565_mix31(m, P) : rgb565_avg(P, m);
               if (A == UL && P != UL) e0 = rgb565_mix31(P, m);
               if (B == DR && P != DR) e3 = rgb565_mix31(P, m);
            }
            if (dc && !ca && !bd)
            {
               uint16_t m = rgb565_avg(D, C);
               e2 = (P == B || P == A) ? rgb565_mix31(m, P) : rgb565_avg(P, m);
               if (C == UL && P != UL) e0 = rgb565_mix31(P, m);
               if (D == DR && P != DR) e3 = rgb565_mix31(P, m);
            }
            if (bd && !ab && !dc)
            {
               uint16_t m = rgb565_avg(B, D);
               e3 = (P == C || P == A) ? rgb565_mix31(m, P) : rgb565_avg(P, m);
               if (B == UR && P != UR) e1 = rgb565_mix31(P, m);
               if (D == DL && P != DL) e2 = rgb565_mix31(P, m);
            }
         }
         out0[x * 2]     = e0;
         out0[x * 2 + 1] = e1;
         out1[x * 2]     = e2;
         out1[x * 2 + 1] = e3;
      }
   }
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
 * Cheat engine for The Mask (USA)
 *
 * Applies active WRAM cheats before/after each frame so health, morph power,
 * lives, ghost invincibility, super moon-jump, and map stage select work
 * seamlessly on both Android and Desktop.
 * ------------------------------------------------------------------------- */
static void apply_cheats(void)
{
   uint8_t *wram;
   size_t size;
   if (!g_loaded || !g_cheats)
      return;
   wram = (uint8_t *)retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
   if (!wram || size < 0x2000)
      return;

   if (g_cheats & CHEAT_INF_HEALTH)
   {
      wram[0x0110] = 1;
      wram[0x0111] = 0;
      if (wram[0x0364] || wram[0x0365])
      {
         wram[0x18AF] = wram[0x0364];
         wram[0x18B0] = wram[0x0365];
      }
      else
      {
         wram[0x18AF] = 0x00;
         wram[0x18B0] = 0x05;
      }
   }

   if (g_cheats & CHEAT_INF_MASK_POWER)
   {
      wram[0x0112] = 1;
      wram[0x0113] = 0;
      if (wram[0x0362] || wram[0x0363])
      {
         wram[0x008F] = wram[0x0362];
         wram[0x0090] = wram[0x0363];
      }
      else
      {
         wram[0x008F] = 0x00;
         wram[0x0090] = 0x05;
      }
   }

   if (g_cheats & CHEAT_INF_LIVES)
   {
      wram[0x010E] = 1;
      wram[0x010F] = 0;
      if (wram[0x0095] < 9)
         wram[0x0095] = 9;
   }

   if (g_cheats & CHEAT_INVINCIBLE)
   {
      wram[0x18B9] = 0x46;
   }

   if ((g_cheats & CHEAT_MOON_JUMP) && (g_mask & (1u << RETRO_DEVICE_ID_JOYPAD_B)))
   {
      wram[0x1894] = 0x80;
      wram[0x1895] = 0xF9;
      wram[0x1896] = 0xFF;
      wram[0x18BC] = 0x80;
      wram[0x18BD] = 0xF9;
      wram[0x18BE] = 0xFF;
   }

   if (g_cheats & CHEAT_LEVEL_SELECT)
   {
      wram[0x0114] = 1;
      wram[0x0115] = 0;
   }
}

static void sync_cheat_flags(unsigned old_cheats, unsigned new_cheats)
{
   uint8_t *wram;
   size_t size;
   unsigned cleared = old_cheats & ~new_cheats;
   if (!g_loaded || !cleared)
      return;
   wram = (uint8_t *)retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
   if (!wram || size < 0x2000)
      return;
   if (cleared & CHEAT_INF_HEALTH)     { wram[0x0110] = 0; wram[0x0111] = 0; }
   if (cleared & CHEAT_INF_MASK_POWER) { wram[0x0112] = 0; wram[0x0113] = 0; }
   if (cleared & CHEAT_INF_LIVES)      { wram[0x010E] = 0; wram[0x010F] = 0; }
   if (cleared & CHEAT_INVINCIBLE)     { wram[0x18B9] = 0; }
   if (cleared & CHEAT_LEVEL_SELECT)   { wram[0x0114] = 0; wram[0x0115] = 0; }
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
   snprintf(g_content_path, sizeof(g_content_path), "%s/themask.sfc", dir);
   {
      FILE *f = fopen(g_content_path, "wb");
      if (f)
      {
         fwrite(g_rom, 1, g_rom_len, f);
         fclose(f);
      }
   }
   snprintf(g_sram_path, sizeof(g_sram_path), "%s/themask.srm", dir);

   retro_set_environment(env_cb);
   retro_set_video_refresh(video_cb);
   retro_set_audio_sample(audio_sample_cb);
   retro_set_audio_sample_batch(audio_cb);
   retro_set_input_poll(input_poll_cb);
   retro_set_input_state(input_state_cb);

   retro_init();
   g_initialised = 1;

   game.path = g_content_path;
   game.data = g_rom;
   game.size = g_rom_len;
   game.meta = NULL;
   if (!retro_load_game(&game))
      return JNI_FALSE;

   /* Player 1: standard SNES pad. */
   retro_set_controller_port_device(0, RETRO_DEVICE_JOYPAD);

   sram_load();

   g_loaded = 1;

   retro_run();          /* first frame also finalises AV info */
   return JNI_TRUE;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeStop(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   if (g_loaded)
   {
      sram_save();
      retro_unload_game();
      g_loaded = 0;
   }
   if (g_initialised)
   {
      retro_deinit();
      g_initialised = 0;
   }
   free(g_rom);
   g_rom = NULL;
   g_rom_len = 0;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeRunFrame(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   g_have_frame = 0;
   apply_cheats();
   retro_run();
   apply_cheats();
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

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetCheats(JNIEnv *env, jclass cls, jint mask)
{
   unsigned next = (unsigned)mask;
   (void)env; (void)cls;
   sync_cheat_flags(g_cheats, next);
   g_cheats = next;
   apply_cheats();
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeGetCheats(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return (jint)g_cheats;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeApplyCheatCode(JNIEnv *env, jclass cls,
                                                    jint index, jboolean enabled, jstring code)
{
   (void)cls;
   if (!g_loaded)
      return;
   if (!code)
   {
      retro_cheat_reset();
      return;
   }
   {
      const char *c = (*env)->GetStringUTFChars(env, code, NULL);
      if (c)
      {
         retro_cheat_set((unsigned)index, enabled ? true : false, c);
         (*env)->ReleaseStringUTFChars(env, code, c);
      }
   }
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

/*
 * Libretro frontend for Genesis Plus GX (Sunset Riders / رعاة البقر),
 * driven from Android through JNI and Desktop through hostjni.
 *
 * Includes:
 *   1. Real-time 2x HQ Pixel-Art Upscaler (Scale2x / EPX + Genesis VDP
 *      horizontal de-dithering) for crystal-clear HD image quality.
 *   2. Hardware-verified 68000 RAM + Game Genie cheat engine for
 *      Sunset Riders (USA) [Sega Genesis].
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

#define SRC_MAX_W 400
#define SRC_MAX_H 300
#define FB_MAX_W  800
#define FB_MAX_H  600
#define AUDIO_RING_FRAMES 16384

/* Video filter modes */
#define VIDEO_FILTER_HD_CRISP  0
#define VIDEO_FILTER_SMOOTH    1
#define VIDEO_FILTER_RAW_PIXEL 2

/* Built-in cheat bitmask for Sunset Riders (USA) [Sega Genesis] */
#define CHEAT_INF_LIVES       (1u << 0)
#define CHEAT_INVINCIBLE      (1u << 1)
#define CHEAT_MAX_FIREPOWER   (1u << 2)
#define CHEAT_INF_CREDITS     (1u << 3)
#define CHEAT_ONE_HIT_BOSS    (1u << 4)
#define CHEAT_INF_LIVES_P2    (1u << 5)

static uint8_t  *g_rom;
static size_t    g_rom_len;
static uint16_t  g_dedith[SRC_MAX_W * SRC_MAX_H];
static uint16_t  g_fb[FB_MAX_W * FB_MAX_H];
static int       g_fb_w, g_fb_h, g_fb_pitch_px;
static int       g_have_frame;
static int       g_video_filter = VIDEO_FILTER_HD_CRISP;

static int16_t   g_audio[AUDIO_RING_FRAMES * 2];
static volatile int g_audio_head, g_audio_tail;   /* in stereo frames */

static unsigned  g_mask;          /* joypad bitmask, libretro button ids */
static unsigned  g_cheats;        /* active cheat bitmask */
static int       g_initialised;   /* retro_init() has run */
static int       g_loaded;        /* a game is loaded and needs unloading */

static char g_save_dir[512];
static char g_content_path[600];
static char g_sram_path[600];
static struct retro_game_info_ext g_game_ext;

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
         g_audio_tail = (g_audio_tail + 1) % AUDIO_RING_FRAMES;
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

static const char *option_value(const char *key)
{
   if (!strcmp(key, "genesis_plus_gx_region_detect")) return "ntsc-u";
   if (!strcmp(key, "genesis_plus_gx_blargg_ntsc_filter")) return "disabled";
   if (!strcmp(key, "genesis_plus_gx_overscan")) return "disabled";
   if (!strcmp(key, "genesis_plus_gx_no_sprite_limit")) return "enabled";
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
         if (data) *(bool *)data = true;
         return true;
      case RETRO_ENVIRONMENT_GET_VARIABLE:
      {
         struct retro_variable *var = (struct retro_variable *)data;
         const char *v = (var && var->key) ? option_value(var->key) : NULL;
         if (var) var->value = v;
         return v != NULL;
      }
      case RETRO_ENVIRONMENT_GET_VARIABLE_UPDATE:
         if (data) *(bool *)data = false;
         return true;
      case RETRO_ENVIRONMENT_GET_LOG_INTERFACE:
         if (data) *(struct retro_log_callback *)data = g_log;
         return true;
      case RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY:
      case RETRO_ENVIRONMENT_GET_SAVE_DIRECTORY:
      {
         const char *dir = g_save_dir[0] ? g_save_dir : ".";
         if (data) *(const char **)data = dir;
         return true;
      }
      case RETRO_ENVIRONMENT_GET_GAME_INFO_EXT:
      {
         if (!g_rom || !g_rom_len || !data)
            return false;
         memset(&g_game_ext, 0, sizeof(g_game_ext));
         g_game_ext.full_path = g_content_path[0] ? g_content_path : "sunsetriders.bin";
         g_game_ext.archive_path = NULL;
         g_game_ext.archive_file = NULL;
         g_game_ext.dir = g_save_dir[0] ? g_save_dir : ".";
         g_game_ext.name = "sunsetriders";
         g_game_ext.ext = "bin";
         g_game_ext.meta = "";
         g_game_ext.data = g_rom;
         g_game_ext.size = g_rom_len;
         g_game_ext.file_in_archive = false;
         g_game_ext.persistent_data = true;
         *(const struct retro_game_info_ext **)data = &g_game_ext;
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
      case RETRO_ENVIRONMENT_SET_CONTENT_INFO_OVERRIDE:
      case RETRO_ENVIRONMENT_SET_DISK_CONTROL_INTERFACE:
         return true;
      case RETRO_ENVIRONMENT_GET_INPUT_BITMASKS:
         return true;
      case RETRO_ENVIRONMENT_GET_LANGUAGE:
         if (data) *(unsigned *)data = RETRO_LANGUAGE_ENGLISH;
         return true;
      case RETRO_ENVIRONMENT_GET_AUDIO_VIDEO_ENABLE:
         if (data) *(int *)data = 3;
         return true;
      default:
         return false;
   }
}

/* ---------------------------------------------------------------------------
 * Real-time 2x HQ Pixel-Art Upscaler (Scale2x / EPX + Genesis De-Dither)
 * ------------------------------------------------------------------------- */
static inline int rgb565_dist(uint16_t a, uint16_t b)
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

static inline uint16_t rgb565_mix31(uint16_t c1, uint16_t c2)
{
   uint32_t r, g, b;
   if (c1 == c2)
      return c1;
   r = (((c1 >> 11) & 0x1F) * 3u + ((c2 >> 11) & 0x1F) + 2u) >> 2;
   g = (((c1 >> 5)  & 0x3F) * 3u + ((c2 >> 5)  & 0x3F) + 2u) >> 2;
   b = ((c1 & 0x1F)         * 3u + (c2 & 0x1F)         + 2u) >> 2;
   return (uint16_t)((r << 11) | (g << 5) | b);
}

static inline uint16_t rgb565_mix11(uint16_t c1, uint16_t c2)
{
   uint32_t r, g, b;
   if (c1 == c2)
      return c1;
   r = (((c1 >> 11) & 0x1F) + ((c2 >> 11) & 0x1F) + 1u) >> 1;
   g = (((c1 >> 5)  & 0x3F) + ((c2 >> 5)  & 0x3F) + 1u) >> 1;
   b = ((c1 & 0x1F)         + (c2 & 0x1F)         + 1u) >> 1;
   return (uint16_t)((r << 11) | (g << 5) | b);
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

   if (g_video_filter == VIDEO_FILTER_RAW_PIXEL)
   {
      g_fb_w = w;
      g_fb_h = h;
      g_fb_pitch_px = w;
      for (y = 0; y < h; y++)
         memcpy(g_fb + y * w, (const uint8_t *)data + y * pitch, (size_t)w * 2);
      g_have_frame = 1;
      return;
   }

   /* Pass 1: Subtle Genesis horizontal dither blending (smooths 1px VDP
    * checkerboard sky/water patterns while keeping real sprite edges sharp). */
   for (y = 0; y < h; y++)
   {
      const uint16_t *src_row = (const uint16_t *)((const uint8_t *)data + y * pitch);
      uint16_t *dst_row = g_dedith + y * w;
      dst_row[0] = src_row[0];
      for (x = 1; x < w - 1; x++)
      {
         uint16_t L = src_row[x - 1];
         uint16_t C = src_row[x];
         uint16_t R = src_row[x + 1];
         if (L == R && L != C && rgb565_dist(L, C) < 22)
            dst_row[x] = rgb565_mix31(C, L);
         else
            dst_row[x] = C;
      }
      if (w > 1)
         dst_row[w - 1] = src_row[w - 1];
   }

   g_fb_w = w * 2;
   g_fb_h = h * 2;
   g_fb_pitch_px = g_fb_w;

   if (g_video_filter == VIDEO_FILTER_SMOOTH)
   {
      /* 2x Smooth Bilinear interpolation */
      for (y = 0; y < h; y++)
      {
         int yp1 = (y + 1 < h) ? (y + 1) : y;
         const uint16_t *row0 = g_dedith + y * w;
         const uint16_t *row1 = g_dedith + yp1 * w;
         uint16_t *out0 = g_fb + (y * 2) * g_fb_w;
         uint16_t *out1 = g_fb + (y * 2 + 1) * g_fb_w;
         for (x = 0; x < w; x++)
         {
            int xp1 = (x + 1 < w) ? (x + 1) : x;
            uint16_t c00 = row0[x];
            uint16_t c10 = row0[xp1];
            uint16_t c01 = row1[x];
            uint16_t c11 = row1[xp1];
            uint16_t top = rgb565_mix11(c00, c10);
            uint16_t bot = rgb565_mix11(c01, c11);
            out0[x * 2]     = c00;
            out0[x * 2 + 1] = top;
            out1[x * 2]     = rgb565_mix11(c00, c01);
            out1[x * 2 + 1] = rgb565_mix11(top, bot);
         }
      }
      g_have_frame = 1;
      return;
   }

   /* Pass 2 (VIDEO_FILTER_HD_CRISP): Perceptual HQ Scale2x (EPX) edge-directed
    * 2x upscaling with anti-aliased diagonal reconstruction. */
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

         int dCA = rgb565_dist(C, A);
         int dAB = rgb565_dist(A, B);
         int dDC = rgb565_dist(D, C);
         int dBD = rgb565_dist(B, D);
         int dCD = rgb565_dist(C, D);
         int dAC = dCA;
         int dDB = dBD;
         int dBA = dAB;

         uint16_t e0 = (dCA < 6 && dCD >= 6 && dAB >= 6) ? rgb565_mix31(A, P) : P;
         uint16_t e1 = (dAB < 6 && dAC >= 6 && dBD >= 6) ? rgb565_mix31(B, P) : P;
         uint16_t e2 = (dDC < 6 && dDB >= 6 && dCA >= 6) ? rgb565_mix31(C, P) : P;
         uint16_t e3 = (dBD < 6 && dBA >= 6 && dDC >= 6) ? rgb565_mix31(D, P) : P;

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
 * Cheat engine for Sunset Riders (USA) [Sega Genesis]
 *
 * Uses both Genesis Plus GX Game Genie ROM patches AND direct 68000 Work RAM
 * ($FF0000..$FFFFFF) reinforcement each frame.
 * Note: Under LSB_FIRST on little-endian hosts, 68000 byte address `addr` is
 * stored at `wram[addr ^ 1]`, while 16-bit word `addr` is `*(uint16_t*)(wram + addr)`.
 * ------------------------------------------------------------------------- */
static void rebuild_rom_cheats(void)
{
   if (!g_loaded)
      return;
   retro_cheat_reset();
   if (g_cheats & CHEAT_INF_LIVES)
      retro_cheat_set(0, true, "REFA-C6VL");
   if (g_cheats & CHEAT_INVINCIBLE)
      retro_cheat_set(1, true, "R11T-A6WN+AM1A-AA6J+AM1T-AA5N");
   if (g_cheats & CHEAT_MAX_FIREPOWER)
      retro_cheat_set(2, true, "AJKA-AA4L");
   if (g_cheats & CHEAT_INF_CREDITS)
      retro_cheat_set(3, true, "AJGA-CA3T");
   if (g_cheats & CHEAT_ONE_HIT_BOSS)
      retro_cheat_set(4, true, "A4NA-CA4Y+A4WA-CA6A+A42T-CA3C+CXBA-CA3J");
}

static void apply_cheats(void)
{
   uint8_t *wram;
   size_t size;
   if (!g_loaded || !g_cheats)
      return;
   wram = (uint8_t *)retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
   if (!wram || size < 0x10000)
      return;

   if (g_cheats & CHEAT_INF_LIVES)
   {
      /* $FFB098 word = 0x0009 (9 reserve lives for P1) */
      wram[0xB098] = 9;
      wram[0xB099] = 0;
   }

   if (g_cheats & CHEAT_INVINCIBLE)
   {
      /* $FFCA4C word = 0x0002 (P1 invincibility / untouchable timer) */
      wram[0xCA4C] = 2;
      wram[0xCA4D] = 0;
   }

   if (g_cheats & CHEAT_MAX_FIREPOWER)
   {
      /* $FFCA42 68000 byte (stored at 0xCA42 ^ 1 = 0xCA43) = 0x03 (2X Guns + Rapid Fire) */
      wram[0xCA43] = 3;
   }

   if (g_cheats & CHEAT_INF_CREDITS)
   {
      /* $FFB0A2 word = 0x0009 (9 credits/continues) */
      wram[0xB0A2] = 9;
      wram[0xB0A3] = 0;
   }

   if (g_cheats & CHEAT_ONE_HIT_BOSS)
   {
      /* Cap boss HP ($FFDADC) and barrel HP ($FFD140, $FFD1C0) to 1 */
      uint16_t *boss_hp = (uint16_t *)(wram + 0xDADC);
      uint16_t *bar1_hp = (uint16_t *)(wram + 0xD140);
      uint16_t *bar2_hp = (uint16_t *)(wram + 0xD1C0);
      if (*boss_hp > 1) *boss_hp = 1;
      if (*bar1_hp > 1) *bar1_hp = 1;
      if (*bar2_hp > 1) *bar2_hp = 1;
   }

   if (g_cheats & CHEAT_INF_LIVES_P2)
   {
      /* $FFB09A word = 0x0009 (9 reserve lives for P2) */
      wram[0xB09A] = 9;
      wram[0xB09B] = 0;
   }
}

static void sync_cheat_flags(unsigned old_cheats, unsigned new_cheats)
{
   uint8_t *wram;
   size_t size;
   unsigned cleared = old_cheats & ~new_cheats;
   if (!g_loaded)
      return;
   wram = (uint8_t *)retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
   size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
   if (wram && size >= 0x10000)
   {
      if (cleared & CHEAT_INVINCIBLE)
      {
         wram[0xCA4C] = 0;
         wram[0xCA4D] = 0;
      }
      if (cleared & CHEAT_MAX_FIREPOWER)
      {
         wram[0xCA43] = 0;
      }
   }
}

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

   snprintf(g_content_path, sizeof(g_content_path), "%s/sunsetriders.bin", dir);
   {
      FILE *f = fopen(g_content_path, "wb");
      if (f)
      {
         fwrite(g_rom, 1, g_rom_len, f);
         fclose(f);
      }
   }
   snprintf(g_sram_path, sizeof(g_sram_path), "%s/sunsetriders.srm", dir);

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

   retro_set_controller_port_device(0, RETRO_DEVICE_JOYPAD);

   sram_load();

   g_loaded = 1;
   rebuild_rom_cheats();

   retro_run();
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
   rebuild_rom_cheats();
   apply_cheats();
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeGetCheats(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return (jint)g_cheats;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(JNIEnv *env, jclass cls, jint mode)
{
   (void)env; (void)cls;
   if (mode >= 0 && mode <= 2)
      g_video_filter = (int)mode;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return (jint)g_video_filter;
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
   return av.timing.fps > 1.0 ? av.timing.fps : 59.9227;
}

JNIEXPORT jdouble JNICALL
Java_com_midoali_snes_SnesCore_nativeSampleRate(JNIEnv *env, jclass cls)
{
   struct retro_system_av_info av;
   (void)env; (void)cls;
   retro_get_system_av_info(&av);
   return av.timing.sample_rate > 1.0 ? av.timing.sample_rate : 44100.0;
}

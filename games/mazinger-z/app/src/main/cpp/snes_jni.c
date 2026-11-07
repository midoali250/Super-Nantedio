/*
 * Libretro frontend for Snes9x 2010 (Mazinger Z / マジンガーZ), driven from
 * Android through JNI and from the desktop builds through hostjni.c.
 *
 *   1. True HD 4x video: Vibrant Arcade color LUT + strict 2D checkerboard
 *      de-dither + two-stage Scale2x/EPX (256x224 -> 1024x896). No bilinear
 *      smearing, no HQ2x edge averaging: pure pixel art, crisp outlines.
 *   2. Cheat engine: Game Genie / Pro Action Replay / raw 7E-xxxx codes go
 *      straight to the core's cheat handler, plus a live RAM cheat finder so
 *      every built-in cheat can be verified instead of hard-coded blindly.
 *   3. Clean hardware reset, SRAM persistence and 60 Hz stereo audio.
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
#define SRC_MAX_H 480
#define MID_MAX_W 1024
#define MID_MAX_H 960
#define FB_MAX_W  2048
#define FB_MAX_H  1920
#define AUDIO_RING_FRAMES 32768

/* Video filter modes */
#define VIDEO_FILTER_HD_CRISP  0
#define VIDEO_FILTER_SMOOTH    1
#define VIDEO_FILTER_RAW_PIXEL 2

static uint8_t  *g_rom;
static size_t    g_rom_len;
static uint16_t  g_lut[65536];
static int       g_lut_ready;
static uint16_t  g_src[SRC_MAX_W * SRC_MAX_H];
static uint16_t  g_mid[MID_MAX_W * MID_MAX_H];
static uint32_t  g_fb_aligned[(FB_MAX_W * FB_MAX_H) / 2];
#define g_fb ((uint16_t *)g_fb_aligned)
static int       g_fb_w, g_fb_h, g_fb_pitch_px;
static int       g_have_frame;
static int       g_video_filter = VIDEO_FILTER_HD_CRISP;

static int16_t   g_audio[AUDIO_RING_FRAMES * 2];
static volatile int g_audio_head, g_audio_tail;   /* in stereo frames */

static unsigned  g_mask;          /* joypad bitmask, libretro button ids */
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
/* ---------------------------------------------------------------------------
 * Core options
 *
 * Every setting the core exposes is live-editable from the app's settings
 * drawer, so "game specific" and audio/video options are really applied and
 * not just displayed.
 * ------------------------------------------------------------------------- */
static int  g_opts_dirty;
static char g_opt_region[16]     = "ntsc";
static char g_opt_interp[16]     = "gaussian";
static char g_opt_aspect[16]     = "4:3";
static char g_opt_frameskip[16]  = "none";
static char g_opt_sprite[16]     = "disabled";
static char g_opt_overclock[16]  = "disabled";
static int  g_opt_superfx       = 0;   /* unused by Mazinger Z, kept for parity */

static const char *option_value(const char *key)
{
   if (!strcmp(key, "snes9x_2010_region"))               return g_opt_region;
   if (!strcmp(key, "snes9x_2010_audio_interpolation"))  return g_opt_interp;
   if (!strcmp(key, "snes9x_2010_aspect"))               return g_opt_aspect;
   if (!strcmp(key, "snes9x_2010_frameskip"))            return g_opt_frameskip;
   if (!strcmp(key, "snes9x_2010_reduce_sprite_flicker")) return g_opt_sprite;
   if (!strcmp(key, "snes9x_2010_overclock"))            return g_opt_overclock;
   if (!strcmp(key, "snes9x_2010_superfx_overclock"))    return "100";
   (void)g_opt_superfx;
   return NULL;
}

static void copy_opt(char *dst, size_t cap, const char *src)
{
   if (!src)
      return;
   strncpy(dst, src, cap - 1);
   dst[cap - 1] = 0;
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
         *(bool *)data = g_opts_dirty;
         g_opts_dirty = 0;
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

/* ---------------------------------------------------------------------------
 * Vibrant Arcade color LUT
 *
 * The SNES DAC is 5 bits per channel (BGR555), so raw 5->8 bit expansion loses
 * highlights and leaves midtones flat. This LUT re-expands to full 0..255,
 * applies a bright arcade gamma lift and a hue-preserving chroma boost so the
 * reds of Mazinger's armour, the blues of the ocean and the sunset skies stay
 * vivid instead of washed out or muddy. Pure black stays pure black.
 * ------------------------------------------------------------------------- */
static void init_color_lut(void)
{
   int v;
   if (g_lut_ready)
      return;
   for (v = 0; v < 65536; v++)
   {
      int r5 = (v >> 11) & 0x1F;
      int g6 = (v >> 5) & 0x3F;
      int b5 = v & 0x1F;
      int r = (r5 << 3) | (r5 >> 2);
      int g = (g6 << 2) | (g6 >> 4);
      int b = (b5 << 3) | (b5 >> 2);
      double rf, gf, bf, mx, mn;
      int ri, gi, bi;

      if (r == 0 && g == 0 && b == 0)
      {
         g_lut[v] = 0;
         continue;
      }

      /* Bright arcade gamma lift: lifts shadows and midtones without touching 0. */
      rf = (double)r / 255.0;
      gf = (double)g / 255.0;
      bf = (double)b / 255.0;
      rf = (rf <= 0.0) ? 0.0 : 255.0 * __builtin_pow(rf, 0.82);
      gf = (gf <= 0.0) ? 0.0 : 255.0 * __builtin_pow(gf, 0.82);
      bf = (bf <= 0.0) ? 0.0 : 255.0 * __builtin_pow(bf, 0.82);

      /* Hue-preserving vibrance: push saturation up while keeping the hue and
       * without clipping a channel to zero (which is what turns colours muddy). */
      mx = rf > gf ? rf : gf;
      if (bf > mx) mx = bf;
      mn = rf < gf ? rf : gf;
      if (bf < mn) mn = bf;
      if (mx > mn && mx > 0.0)
      {
         double boost = mx * 1.04;
         double sat = (mx - mn) / mx;
         double new_sat = sat * 1.22;
         double new_mn, k;
         if (boost > 255.0) boost = 255.0;
         if (new_sat > 1.0) new_sat = 1.0;
         new_mn = boost * (1.0 - new_sat);
         k = (boost - new_mn) / (mx - mn);
         rf = new_mn + (rf - mn) * k;
         gf = new_mn + (gf - mn) * k;
         bf = new_mn + (bf - mn) * k;
      }

      ri = (int)(rf + 0.5);
      gi = (int)(gf + 0.5);
      bi = (int)(bf + 0.5);
      if (ri < 0) ri = 0; else if (ri > 255) ri = 255;
      if (gi < 0) gi = 0; else if (gi > 255) gi = 255;
      if (bi < 0) bi = 0; else if (bi > 255) bi = 255;

      g_lut[v] = (uint16_t)(((ri >> 3) << 11) | ((gi >> 2) << 5) | (bi >> 3));
   }
   g_lut_ready = 1;
}

static inline uint16_t rgb565_avg(uint16_t a, uint16_t b)
{
   return (uint16_t)((a & b) + (((a ^ b) & 0xF7DEu) >> 1));
}

/* Soft 2x bilinear, only used by the optional "Ultra Smooth" mode. */
static void bilinear2x(const uint16_t *src, int w, int h, uint16_t *dst)
{
   int dst_w = w * 2;
   int x, y;
   for (y = 0; y < h; y++)
   {
      int yp1 = (y + 1 < h) ? (y + 1) : y;
      const uint16_t *row0 = src + y * w;
      const uint16_t *row1 = src + yp1 * w;
      uint16_t *out0 = dst + (y * 2) * dst_w;
      uint16_t *out1 = dst + (y * 2 + 1) * dst_w;
      for (x = 0; x < w; x++)
      {
         int xp1 = (x + 1 < w) ? (x + 1) : x;
         uint16_t c00 = row0[x], c10 = row0[xp1], c01 = row1[x], c11 = row1[xp1];
         uint16_t top = rgb565_avg(c00, c10);
         out0[x * 2] = c00;
         out0[x * 2 + 1] = top;
         out1[x * 2] = rgb565_avg(c00, c01);
         out1[x * 2 + 1] = rgb565_avg(top, rgb565_avg(c01, c11));
      }
   }
}

/* Pure Scale2x / EPX: rounds diagonals without inventing blended edge colours,
 * so black outlines and one-pixel sprite detail stay perfectly sharp. */
static void ep2x(const uint16_t *src, int w, int h, uint16_t *dst)
{
   int dst_w = w * 2;
   int x, y;
   for (y = 0; y < h; y++)
   {
      int ym1 = (y > 0) ? (y - 1) : 0;
      int yp1 = (y + 1 < h) ? (y + 1) : (h - 1);
      const uint16_t *rowA = src + ym1 * w;
      const uint16_t *rowP = src + y * w;
      const uint16_t *rowD = src + yp1 * w;
      uint16_t *out0 = dst + (y * 2) * dst_w;
      uint16_t *out1 = dst + (y * 2 + 1) * dst_w;
      for (x = 0; x < w; x++)
      {
         int xm1 = (x > 0) ? (x - 1) : 0;
         int xp1 = (x + 1 < w) ? (x + 1) : (w - 1);
         uint16_t P = rowP[x], A = rowA[x], B = rowP[xp1], C = rowP[xm1], D = rowD[x];
         uint16_t e0 = P, e1 = P, e2 = P, e3 = P;
         if (C != B && A != D)
         {
            if (C == A) e0 = A;
            if (A == B) e1 = B;
            if (D == C) e2 = C;
            if (B == D) e3 = D;
         }
         out0[x * 2] = e0;
         out0[x * 2 + 1] = e1;
         out1[x * 2] = e2;
         out1[x * 2 + 1] = e3;
      }
   }
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

   init_color_lut();

   if (g_video_filter == VIDEO_FILTER_RAW_PIXEL)
   {
      g_fb_w = w;
      g_fb_h = h;
      g_fb_pitch_px = w;
      for (y = 0; y < h; y++)
      {
         const uint16_t *src = (const uint16_t *)((const uint8_t *)data + y * pitch);
         uint16_t *dst = g_fb + y * w;
         for (x = 0; x < w; x++)
            dst[x] = g_lut[src[x]];
      }
      g_have_frame = 1;
      return;
   }

   /* Pass 1: vibrant LUT + strict 2D checkerboard de-dither.
    * Only true alternating dither tiles (left == right, top or bottom matches,
    * and at least two matching diagonals) are resolved, so gradient skies
    * smooth out while text, eyes and sprite outlines are never smeared. */
   for (y = 0; y < h; y++)
   {
      int ym1 = (y > 0) ? (y - 1) : 0;
      int yp1 = (y + 1 < h) ? (y + 1) : (h - 1);
      const uint16_t *rowA = (const uint16_t *)((const uint8_t *)data + ym1 * pitch);
      const uint16_t *rowP = (const uint16_t *)((const uint8_t *)data + y * pitch);
      const uint16_t *rowD = (const uint16_t *)((const uint8_t *)data + yp1 * pitch);
      uint16_t *dst_row = g_src + y * w;
      for (x = 0; x < w; x++)
      {
         int xm1 = (x > 0) ? (x - 1) : 0;
         int xp1 = (x + 1 < w) ? (x + 1) : (w - 1);
         uint16_t rawP = rowP[x], rawC = rowP[xm1], rawB = rowP[xp1];
         uint16_t P = g_lut[rawP];
         if (rawC == rawB && rawC != rawP && (rowA[x] == rawC || rowD[x] == rawC))
         {
            int diag = (rowA[xm1] == rawP) + (rowA[xp1] == rawP) +
                       (rowD[xm1] == rawP) + (rowD[xp1] == rawP);
            if (diag >= 2)
            {
               dst_row[x] = rgb565_avg(P, g_lut[rawC]);
               continue;
            }
         }
         dst_row[x] = P;
      }
   }

   /* Pass 2: 4x True HD (Scale2x twice) or the softer bilinear variant. */
   if (g_video_filter == VIDEO_FILTER_SMOOTH)
   {
      bilinear2x(g_src, w, h, g_mid);
      bilinear2x(g_mid, w * 2, h * 2, g_fb);
   }
   else
   {
      ep2x(g_src, w, h, g_mid);
      ep2x(g_mid, w * 2, h * 2, g_fb);
   }
   g_fb_w = w * 4;
   g_fb_h = h * 4;
   g_fb_pitch_px = g_fb_w;
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

/* ---------------------------------------------------------------------------
 * Cheat engine
 *
 * Built-in cheats are applied to the console WRAM every frame (so they cannot
 * stop working when the game rewrites a value), and any Game Genie, Pro Action
 * Replay or raw 7E-xxxx code the user types is handed to the core's own cheat
 * handler which patches the ROM/RAM exactly like RetroArch does.
 * ------------------------------------------------------------------------- */
#define CHEAT_INF_LIVES     (1u << 0)
#define CHEAT_INVINCIBLE    (1u << 1)
#define CHEAT_MAX_POWER     (1u << 2)
#define CHEAT_MOON_JUMP     (1u << 3)
#define CHEAT_INF_TIME      (1u << 4)
#define CHEAT_SUPER_SPEED   (1u << 5)
#define CHEAT_RAPID_FIRE    (1u << 6)

static unsigned g_cheats;
static int      g_custom_cheat_used;
static unsigned g_rapid_fire_phase;

static uint8_t *wram_ptr(size_t *size)
{
   if (!g_loaded)
      return NULL;
   *size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
   if (*size < 0x2000)
      return NULL;
   return (uint8_t *)retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
}

/* Called right before retro_run(): everything here must be idempotent. */
static void cheats_pre_frame(void)
{
   size_t size = 0;
   uint8_t *wram = wram_ptr(&size);
   if (!wram || !g_cheats)
      return;

   /* Infinite lives / credits: the HUD only ever counts down. */
   if (g_cheats & CHEAT_INF_LIVES)
   {
      wram[0x0036] = 5;   /* credits */
      wram[0x0038] = 3;   /* lives  */
   }

   /* Invincibility: the damage routine clears this timer before it applies a
    * hit, so keeping it primed makes Mazinger ignore enemy contact. */
   if (g_cheats & CHEAT_INVINCIBLE)
      wram[0x0A4F] = 0x40;

   /* Moon jump: while B is held, force the vertical velocity upward. */
   if ((g_cheats & CHEAT_MOON_JUMP) && (g_mask & (1u << RETRO_DEVICE_ID_JOYPAD_B)))
   {
      wram[0x0AB8] = 0x00;
      wram[0x0AB9] = 0xF8;
   }

   /* Super speed: keep the horizontal walk counter moving. */
   if (g_cheats & CHEAT_SUPER_SPEED)
      wram[0x0A44] = 0x04;
}

/* Runs after retro_run() so a value the game just consumed is restored. */
static void cheats_post_frame(void)
{
   size_t size = 0;
   uint8_t *wram = wram_ptr(&size);
   if (!wram)
      return;
   if (g_cheats & CHEAT_RAPID_FIRE)
   {
      /* Re-assert the fire button every other frame: the game reads the pad
       * edge, so alternating gives an auto-fire rate without touching audio. */
      g_rapid_fire_phase++;
      if ((g_rapid_fire_phase & 1) && !(g_mask & (1u << RETRO_DEVICE_ID_JOYPAD_Y)))
         g_mask |= (1u << RETRO_DEVICE_ID_JOYPAD_Y);
      else
         g_mask &= ~(1u << RETRO_DEVICE_ID_JOYPAD_Y);
   }
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
   cheats_pre_frame();
   retro_run();
   cheats_post_frame();
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

/* ---------------------------------------------------------------------------
 * Reset, video filter, cheats and RAM access
 * ------------------------------------------------------------------------- */
JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeReset(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   if (!g_loaded)
      return;
   g_mask = 0;
   retro_reset();
   g_lut_ready = 1;              /* the LUT survives a reset */
   retro_run();                  /* warm up so the screen never stays blank */
   g_have_frame = 1;
   g_fb_w = 256 * 4;
   g_fb_h = 224 * 4;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(JNIEnv *env, jclass cls, jint mode)
{
   (void)env; (void)cls;
   if (mode >= VIDEO_FILTER_HD_CRISP && mode <= VIDEO_FILTER_RAW_PIXEL)
      g_video_filter = (int)mode;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return g_video_filter;
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetCheats(JNIEnv *env, jclass cls, jint mask)
{
   (void)env; (void)cls;
   g_cheats = (unsigned)mask;
}

JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeGetCheats(JNIEnv *env, jclass cls)
{
   (void)env; (void)cls;
   return (jint)g_cheats;
}

/* Register one Game Genie / Pro Action Replay / raw code with the core.
 * Passing a NULL code resets the list, exactly like RetroArch does. */
JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeApplyCheatCode(JNIEnv *env, jclass cls,
                                                    jint index, jboolean enabled, jstring code)
{
   const char *c;
   (void)cls;
   if (!g_loaded)
      return 0;
   if (!code)
   {
      retro_cheat_reset();
      g_custom_cheat_used = 0;
      return 1;
   }
   c = (*env)->GetStringUTFChars(env, code, NULL);
   if (!c)
      return 0;
   retro_cheat_set((unsigned)index, enabled ? true : false, c);
   (*env)->ReleaseStringUTFChars(env, code, c);
   g_custom_cheat_used = 1;
   return 1;
}

/* Live RAM access so the app can build a cheat finder / show values. */
JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeReadRamByte(JNIEnv *env, jclass cls, jint address)
{
   size_t size = 0;
   uint8_t *wram = wram_ptr(&size);
   (void)env; (void)cls;
   if (!wram || address < 0 || address >= (jint)size)
      return -1;
   return wram[address];
}

JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeWriteRamByte(JNIEnv *env, jclass cls, jint address, jint value)
{
   size_t size = 0;
   uint8_t *wram = wram_ptr(&size);
   (void)env; (void)cls;
   if (!wram || address < 0 || address >= (jint)size)
      return;
   wram[address] = (uint8_t)(value & 0xFF);
}

/* ---------------------------------------------------------------------------
 * Live core options (region / interpolation / aspect / frameskip / flicker)
 * index: 0 region, 1 interpolation, 2 aspect, 3 frameskip, 4 reduce flicker
 * ------------------------------------------------------------------------- */
JNIEXPORT void JNICALL
Java_com_midoali_snes_SnesCore_nativeSetCoreOption(JNIEnv *env, jclass cls, jint index, jstring value)
{
   const char *v;
   (void)cls;
   if (!value)
      return;
   v = (*env)->GetStringUTFChars(env, value, NULL);
   if (!v)
      return;
   switch (index)
   {
      case 0: copy_opt(g_opt_region, sizeof(g_opt_region), v); break;
      case 1: copy_opt(g_opt_interp, sizeof(g_opt_interp), v); break;
      case 2: copy_opt(g_opt_aspect, sizeof(g_opt_aspect), v); break;
      case 3: copy_opt(g_opt_frameskip, sizeof(g_opt_frameskip), v); break;
      case 4: copy_opt(g_opt_sprite, sizeof(g_opt_sprite), v); break;
      case 5: copy_opt(g_opt_overclock, sizeof(g_opt_overclock), v); break;
      default: break;
   }
   (*env)->ReleaseStringUTFChars(env, value, v);
   g_opts_dirty = 1;
}

JNIEXPORT jstring JNICALL
Java_com_midoali_snes_SnesCore_nativeGetCoreOption(JNIEnv *env, jclass cls, jint index)
{
   const char *v = "";
   (void)cls;
   switch (index)
   {
      case 0: v = g_opt_region; break;
      case 1: v = g_opt_interp; break;
      case 2: v = g_opt_aspect; break;
      case 3: v = g_opt_frameskip; break;
      case 4: v = g_opt_sprite; break;
      case 5: v = g_opt_overclock; break;
      default: break;
   }
   return (*env)->NewStringUTF(env, v);
}

/* Quick save/restore (SRAM + savestate are handled by the core). */
JNIEXPORT jint JNICALL
Java_com_midoali_snes_SnesCore_nativeSaveState(JNIEnv *env, jclass cls, jbyteArray out)
{
   jsize len = (*env)->GetArrayLength(env, out);
   size_t need = 0;
   jbyte *tmp;
   int ok;
   (void)cls;
   if (!g_loaded)
      return 0;
   need = retro_serialize_size();
   if (need == 0 || (jsize)need > len)
      return 0;
   tmp = (jbyte *)malloc(need);
   if (!tmp)
      return 0;
   ok = retro_serialize(tmp, need) ? (int)need : 0;
   if (ok)
      (*env)->SetByteArrayRegion(env, out, 0, ok, tmp);
   free(tmp);
   return ok;
}

JNIEXPORT jboolean JNICALL
Java_com_midoali_snes_SnesCore_nativeLoadState(JNIEnv *env, jclass cls, jbyteArray in, jint length)
{
   jsize len = (*env)->GetArrayLength(env, in);
   jbyte *tmp;
   int ok;
   (void)cls;
   if (!g_loaded || length <= 0 || length > len)
      return JNI_FALSE;
   tmp = (jbyte *)malloc((size_t)length);
   if (!tmp)
      return JNI_FALSE;
   (*env)->GetByteArrayRegion(env, in, 0, length, tmp);
   ok = retro_unserialize(tmp, (size_t)length) ? 1 : 0;
   free(tmp);
   g_have_frame = 0;
   return ok ? JNI_TRUE : JNI_FALSE;
}

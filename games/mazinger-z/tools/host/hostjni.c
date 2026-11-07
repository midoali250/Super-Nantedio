/*
 * Host shim that lets the real snes_jni.c run on a desktop build.
 *
 * It fabricates the four JNI objects snes_jni.c touches (byte[] rom,
 * direct ByteBuffer, short[] audio, save path string) and exposes a flat C
 * API that a test driver can call.
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "jni.h"
#include "hostjni.h"

/* objects handed to snes_jni.c */
typedef struct { const uint8_t *data; int len; } ByteArrayObj;
typedef struct { void *ptr; int64_t cap; } BufferObj;
typedef struct { int16_t *data; int len; } ShortArrayObj;

static jint  iface_len(JNIEnv *env, jarray a) { (void)env; return a ? ((ByteArrayObj *)a)->len : 0; }
static void  iface_get(JNIEnv *env, jbyteArray a, jint start, jint len, jbyte *buf)
{
   (void)env;
   if (!a) return;
   memcpy(buf, ((ByteArrayObj *)a)->data + start, (size_t)len);
}
static const char *iface_str(JNIEnv *env, jstring s, jboolean *copy)
{
   (void)env;
   if (copy) *copy = 0;
   return (const char *)s;
}
static void iface_rel(JNIEnv *env, jstring s, const char *c) { (void)env; (void)s; (void)c; }
static void *iface_buf(JNIEnv *env, jobject o) { (void)env; return o ? ((BufferObj *)o)->ptr : NULL; }
static jlong iface_cap(JNIEnv *env, jobject o) { (void)env; return o ? ((BufferObj *)o)->cap : 0; }
static void  iface_set(JNIEnv *env, jshortArray a, jint start, jint len, const jshort *buf)
{
   (void)env;
   if (!a) return;
   memcpy(((ShortArrayObj *)a)->data + start, buf, (size_t)len * sizeof(int16_t));
}
static void iface_setbytes(JNIEnv *env, jbyteArray a, jint start, jint len, const jbyte *buf)
{
   (void)env;
   if (!a) return;
   memcpy(((ByteArrayObj *)a)->data + start, buf, (size_t)len);
}
static jstring iface_newstr(JNIEnv *env, const char *utf) { (void)env; return (jstring)utf; }

static const struct JNINativeInterface_ g_iface = {
   iface_len, iface_get, iface_str, iface_rel, iface_buf, iface_cap, iface_set,
   iface_setbytes, iface_newstr,
};
static JNIEnv g_env = &g_iface;

/* ---- the entry points defined in snes_jni.c ---- */
jboolean Java_com_midoali_snes_SnesCore_nativeStart(JNIEnv *, jclass, jbyteArray, jstring);
void     Java_com_midoali_snes_SnesCore_nativeStop(JNIEnv *, jclass);
void     Java_com_midoali_snes_SnesCore_nativeRunFrame(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeFrameWidth(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeFrameHeight(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeCopyVideo(JNIEnv *, jclass, jobject);
void     Java_com_midoali_snes_SnesCore_nativeSetInput(JNIEnv *, jclass, jint);
jint     Java_com_midoali_snes_SnesCore_nativeReadAudio(JNIEnv *, jclass, jshortArray, jint);
void     Java_com_midoali_snes_SnesCore_nativeReset(JNIEnv *, jclass);
void     Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(JNIEnv *, jclass, jint);
jint     Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(JNIEnv *, jclass);
void     Java_com_midoali_snes_SnesCore_nativeSetCheats(JNIEnv *, jclass, jint);
jint     Java_com_midoali_snes_SnesCore_nativeGetCheats(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeApplyCheatCode(JNIEnv *, jclass, jint, jboolean, jstring);
jint     Java_com_midoali_snes_SnesCore_nativeReadRamByte(JNIEnv *, jclass, jint);
void     Java_com_midoali_snes_SnesCore_nativeSetCoreOption(JNIEnv *, jclass, jint, jstring);
jstring  Java_com_midoali_snes_SnesCore_nativeGetCoreOption(JNIEnv *, jclass, jint);
jint     Java_com_midoali_snes_SnesCore_nativeSaveState(JNIEnv *, jclass, jbyteArray);
jboolean Java_com_midoali_snes_SnesCore_nativeLoadState(JNIEnv *, jclass, jbyteArray, jint);
void     Java_com_midoali_snes_SnesCore_nativeWriteRamByte(JNIEnv *, jclass, jint, jint);

static unsigned char g_video[1024 * 1024];
static int16_t g_audio[65536];
static int16_t g_audio_out[65536];

int host_start(const unsigned char *rom, int len)
{
   ByteArrayObj arr;
   arr.data = rom;
   arr.len = len;
   return Java_com_midoali_snes_SnesCore_nativeStart(&g_env, NULL, (jbyteArray)&arr,
                                                   (jstring)"/tmp") ? 1 : 0;
}

void host_stop(void)
{
   Java_com_midoali_snes_SnesCore_nativeStop(&g_env, NULL);
}

void host_frame(void)
{
   Java_com_midoali_snes_SnesCore_nativeRunFrame(&g_env, NULL);
}

void host_input(int mask)
{
   Java_com_midoali_snes_SnesCore_nativeSetInput(&g_env, NULL, mask);
}

int host_width(void) { return Java_com_midoali_snes_SnesCore_nativeFrameWidth(&g_env, NULL); }
int host_height(void) { return Java_com_midoali_snes_SnesCore_nativeFrameHeight(&g_env, NULL); }

int host_video(unsigned char *out, int cap)
{
   BufferObj b;
   int w, h, need;
   b.ptr = out;
   b.cap = cap;
   if (!Java_com_midoali_snes_SnesCore_nativeCopyVideo(&g_env, NULL, (jobject)&b))
      return 0;
   w = host_width();
   h = host_height();
   need = w * h * 2;
   return need <= cap ? need : 0;
}

int host_read_audio(int16_t *out, int maxFrames)
{
   ShortArrayObj a;
   a.data = g_audio_out;
   a.len = 65536;
   int n = Java_com_midoali_snes_SnesCore_nativeReadAudio(&g_env, NULL, (jshortArray)&a, maxFrames);
   if (n > 0) memcpy(out, g_audio_out, (size_t)n * 2 * sizeof(int16_t));
   return n;
}

int host_audio_total(void)
{
   int n = 0, k;
   for (k = 0; k < 100; k++)
   {
      int got = host_read_audio(g_audio, 2048);
      if (got <= 0) break;
      n += got;
   }
   return n;
}

void host_reset(void) { Java_com_midoali_snes_SnesCore_nativeReset(&g_env, NULL); }
void host_set_video_filter(int mode) { Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(&g_env, NULL, mode); }
int  host_get_video_filter(void) { return Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(&g_env, NULL); }
void host_set_cheats(int mask) { Java_com_midoali_snes_SnesCore_nativeSetCheats(&g_env, NULL, mask); }
int  host_get_cheats(void) { return Java_com_midoali_snes_SnesCore_nativeGetCheats(&g_env, NULL); }
int  host_apply_cheat_code(int index, int enabled, const char *code)
{
   return Java_com_midoali_snes_SnesCore_nativeApplyCheatCode(&g_env, NULL, index,
                                                             enabled ? 1 : 0, (jstring)code);
}
int  host_read_ram(int address) { return Java_com_midoali_snes_SnesCore_nativeReadRamByte(&g_env, NULL, address); }
void host_write_ram(int address, int value) { Java_com_midoali_snes_SnesCore_nativeWriteRamByte(&g_env, NULL, address, value); }
void host_set_core_option(int index, const char *value)
{
   Java_com_midoali_snes_SnesCore_nativeSetCoreOption(&g_env, NULL, index, (jstring)value);
}
const char *host_get_core_option(int index)
{
   return (const char *)Java_com_midoali_snes_SnesCore_nativeGetCoreOption(&g_env, NULL, index);
}
/* Savestates, used by the tests to make RAM hunting deterministic. */
static unsigned char g_state[1024 * 1024];
int host_save_state(void)
{
   ByteArrayObj arr;
   arr.data = g_state;
   arr.len = (int)sizeof(g_state);
   return (int)Java_com_midoali_snes_SnesCore_nativeSaveState(&g_env, NULL, (jbyteArray)&arr);
}
int host_load_state(void)
{
   ByteArrayObj arr;
   arr.data = g_state;
   arr.len = (int)sizeof(g_state);
   return Java_com_midoali_snes_SnesCore_nativeLoadState(&g_env, NULL, (jbyteArray)&arr, arr.len) ? 1 : 0;
}

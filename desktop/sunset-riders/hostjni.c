/*
 * Host shim that lets the real snes_jni.c run on a desktop build.
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "jni.h"
#include "hostjni.h"

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

static const struct JNINativeInterface_ g_iface = {
   iface_len, iface_get, iface_str, iface_rel, iface_buf, iface_cap, iface_set,
};
static JNIEnv g_env = &g_iface;

jboolean Java_com_midoali_snes_SnesCore_nativeStart(JNIEnv *, jclass, jbyteArray, jstring);
void     Java_com_midoali_snes_SnesCore_nativeReset(JNIEnv *, jclass);
void     Java_com_midoali_snes_SnesCore_nativeStop(JNIEnv *, jclass);
void     Java_com_midoali_snes_SnesCore_nativeRunFrame(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeFrameWidth(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeFrameHeight(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeCopyVideo(JNIEnv *, jclass, jobject);
void     Java_com_midoali_snes_SnesCore_nativeSetInput(JNIEnv *, jclass, jint);
void     Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(JNIEnv *, jclass, jint);
jint     Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(JNIEnv *, jclass);
jint     Java_com_midoali_snes_SnesCore_nativeReadAudio(JNIEnv *, jclass, jshortArray, jint);

static unsigned char g_video[2048 * 1024];
static int16_t g_audio[65536];
static int16_t g_audio_out[65536];

int host_start(const unsigned char *rom, int len)
{
   ByteArrayObj arr;
   const char *tmp = getenv("SUNSET_RIDERS_TEMP");
   arr.data = rom;
   arr.len = len;
   return Java_com_midoali_snes_SnesCore_nativeStart(&g_env, NULL, (jbyteArray)&arr,
                                                   (jstring)(tmp && tmp[0] ? tmp : ".")) ? 1 : 0;
}

void host_reset(void)
{
   Java_com_midoali_snes_SnesCore_nativeReset(&g_env, NULL);
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

void host_set_video_filter(int mode)
{
   Java_com_midoali_snes_SnesCore_nativeSetVideoFilter(&g_env, NULL, mode);
}

int host_get_video_filter(void)
{
   return Java_com_midoali_snes_SnesCore_nativeGetVideoFilter(&g_env, NULL);
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

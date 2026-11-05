/*
 * Tiny stand-in for the JDK's jni.h so that app/src/main/cpp/snes_jni.c can be
 * compiled and exercised on a normal Linux host (no device needed).
 *
 * Only the handful of JNIEnv functions that snes_jni.c actually calls are
 * declared here; hostjni.c supplies them.
 */
#ifndef HOST_JNI_SHIM_H
#define HOST_JNI_SHIM_H

#include <stdint.h>
#include <stddef.h>

typedef int8_t   jbyte;
typedef int16_t  jshort;
typedef int32_t  jint;
typedef int32_t  jsize;
typedef int64_t  jlong;
typedef uint8_t  jboolean;
typedef float    jfloat;
typedef double   jdouble;
typedef void    *jobject;
typedef void    *jclass;
typedef void    *jstring;
typedef void    *jarray;
typedef void    *jbyteArray;
typedef void    *jshortArray;

#define JNICALL
#define JNIEXPORT
#define JNI_TRUE  1
#define JNI_FALSE 0

struct JNINativeInterface_;
typedef const struct JNINativeInterface_ *JNIEnv;

struct JNINativeInterface_ {
   jint        (*GetArrayLength)(JNIEnv *env, jarray array);
   void        (*GetByteArrayRegion)(JNIEnv *env, jbyteArray array, jint start, jint len, jbyte *buf);
   const char *(*GetStringUTFChars)(JNIEnv *env, jstring str, jboolean *isCopy);
   void        (*ReleaseStringUTFChars)(JNIEnv *env, jstring str, const char *chars);
   void       *(*GetDirectBufferAddress)(JNIEnv *env, jobject buf);
   jlong       (*GetDirectBufferCapacity)(JNIEnv *env, jobject buf);
   void        (*SetShortArrayRegion)(JNIEnv *env, jshortArray array, jint start, jint len, const jshort *buf);
};

#endif

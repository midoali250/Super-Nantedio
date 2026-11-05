#ifndef HOSTJNI_H
#define HOSTJNI_H
#include <stdint.h>
int  host_start(const unsigned char *rom, int len);
void host_stop(void);
void host_frame(void);
void host_input(int mask);
int  host_width(void);
int  host_height(void);
int  host_video(unsigned char *out, int cap);
int  host_read_audio(int16_t *out, int maxFrames);
int  host_audio_total(void);
#endif

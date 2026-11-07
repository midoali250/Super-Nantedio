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
void host_reset(void);
void host_set_video_filter(int mode);
int  host_get_video_filter(void);
void host_set_cheats(int mask);
int  host_get_cheats(void);
int  host_apply_cheat_code(int index, int enabled, const char *code);
int  host_read_ram(int address);
void host_write_ram(int address, int value);
int  host_save_state(void);
int  host_load_state(void);
#endif

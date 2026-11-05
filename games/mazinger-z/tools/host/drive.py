#!/usr/bin/env python3
"""Drive the *app's own* JNI frontend (snes_jni.c) on the desktop.

The Android build and this host build share app/src/main/cpp/snes_jni.c, so the
checks here exercise the same ROM loading, core options, input ids and audio
path that the APK uses.

Usage:
    python3 tools/host/drive.py <rom.smc> [--frames N] [--shot every=N] [--press KEY:N]
"""
import argparse
import ctypes as C
import sys
import time
from pathlib import Path

from PIL import Image

LIB = Path(__file__).with_name("build") / "libsnesapp_host.so"

# libretro RETRO_DEVICE_ID_JOYPAD_* ids
BUTTONS = {
    'B': 0, 'Y': 1, 'SELECT': 2, 'START': 3,
    'UP': 4, 'DOWN': 5, 'LEFT': 6, 'RIGHT': 7,
    'A': 8, 'X': 9, 'L': 10, 'R': 11,
}


def mask_of(*names):
    m = 0
    for n in names:
        m |= 1 << BUTTONS[n]
    return m


class App:
    def __init__(self, rom_path):
        self.lib = C.CDLL(str(LIB))
        self.lib.host_start.argtypes = [C.c_char_p, C.c_int]
        self.lib.host_start.restype = C.c_int
        self.lib.host_frame.argtypes = []
        self.lib.host_input.argtypes = [C.c_int]
        self.lib.host_width.argtypes = []
        self.lib.host_width.restype = C.c_int
        self.lib.host_height.argtypes = []
        self.lib.host_height.restype = C.c_int
        self.lib.host_video.argtypes = [C.c_char_p, C.c_int]
        self.lib.host_video.restype = C.c_int
        self.lib.host_read_audio.argtypes = [C.c_char_p, C.c_int]
        self.lib.host_read_audio.restype = C.c_int
        self.lib.host_stop.argtypes = []

        data = Path(rom_path).read_bytes()
        if not self.lib.host_start(data, len(data)):
            raise SystemExit("core rejected the ROM")
        self.w = self.lib.host_width()
        self.h = self.lib.host_height()
        self.buf = C.create_string_buffer(self.w * self.h * 2)

    def frame(self, mask=0):
        self.lib.host_input(mask)
        self.lib.host_frame()
        self.lib.host_video(self.buf, len(self.buf))

    def image(self):
        raw = self.buf.raw[:self.w * self.h * 2]
        return Image.frombytes('RGB', (self.w, self.h), raw, 'raw', 'BGR;16')

    def audio(self, frames=4096):
        out = C.create_string_buffer(frames * 4)
        n = self.lib.host_read_audio(out, frames)
        return n

    def stop(self):
        self.lib.host_stop()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('rom')
    ap.add_argument('--frames', type=int, default=120)
    ap.add_argument('--shot', type=int, default=0, help='save a PNG every N frames')
    ap.add_argument('--out', default='out')
    ap.add_argument('--press', action='append', default=[],
                    help='KEY[@frame] to hold, e.g. START@60')
    args = ap.parse_args()

    outdir = Path(args.out)
    outdir.mkdir(exist_ok=True)

    app = App(args.rom)
    print(f"ROM      : {args.rom}")
    print(f"frame    : {app.w}x{app.h}")

    presses = {}
    for spec in args.press:
        if '@' in spec:
            key, fr = spec.split('@')
            presses.setdefault(int(fr), []).append(key)
        else:
            presses.setdefault(0, []).append(spec)

    audio_frames = 0
    t0 = time.time()
    for i in range(args.frames):
        held = presses.get(i, [])
        m = mask_of(*held) if held else 0
        app.frame(m)
        audio_frames += app.audio()
        if args.shot and i % args.shot == 0:
            img = app.image()
            p = outdir / f"frame_{i:05d}.png"
            img.save(p)
            print(f"  frame {i:5d} -> {p.name}  (held: {','.join(held) or '-'})")
    dt = time.time() - t0

    img = app.image()
    colors = img.getcolors(maxcolors=100000)
    non_black = sum(c for c, _ in colors) if colors else 0
    final = outdir / "final.png"
    img.save(final)

    print(f"frames   : {args.frames} in {dt:.2f}s -> {args.frames/dt:.1f} fps (host speed)")
    print(f"audio    : {audio_frames} stereo frames")
    print(f"distinct colours in last frame: {len(colors) if colors else '>100000'}")
    print(f"non-black pixels: {non_black}/{app.w*app.h} "
          f"({100.0*non_black/(app.w*app.h):.1f}%)")
    print(f"final frame -> {final}")
    app.stop()
    return 0 if non_black > 100 else 1


if __name__ == '__main__':
    sys.exit(main())

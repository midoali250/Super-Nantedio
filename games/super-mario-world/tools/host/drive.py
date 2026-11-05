#!/usr/bin/env python3
"""Drive the *app's own* JNI frontend (nes_jni.c) on the desktop.

The Android build and this host build share app/src/main/cpp/nes_jni.c, so the
checks here exercise the same ROM loading, core options, input ids and audio
path that the APK uses.
"""
import ctypes as C
import sys
from pathlib import Path

from PIL import Image

LIB = Path(__file__).with_name("build") / "libnesapp_host.so"

BTN = {'B': 0, 'SELECT': 2, 'START': 3, 'UP': 4, 'DOWN': 5, 'LEFT': 6, 'RIGHT': 7, 'A': 8}


def gun_x(px):
    return max(-32768, min(32767, round(px * 65532 / 256) - 32766))


def gun_y(py):
    return max(-32768, min(32767, round(py * 65536 / 240) - 32768))


class App:
    def __init__(self, rom, outdir="out"):
        self.lib = C.CDLL(str(LIB))
        self.lib.host_start.argtypes = [C.c_char_p, C.c_int]
        self.lib.host_video.argtypes = [C.c_char_p, C.c_int]
        self.lib.host_read_audio.argtypes = [C.POINTER(C.c_int16), C.c_int]
        data = Path(rom).read_bytes()
        assert self.lib.host_start(data, len(data)), "rom rejected by the core"
        self.w = self.lib.host_width()
        self.h = self.lib.host_height()
        self.buf = C.create_string_buffer(self.w * self.h * 2)
        self.audio = (C.c_int16 * 8192)()
        self.out = Path(outdir)
        self.out.mkdir(parents=True, exist_ok=True)
        self.frame = 0
        self.audio_frames = 0
        self.mask = 0
        self.gun = (gun_x(128), gun_y(120), 0)

    # -- running -----------------------------------------------------------
    def run(self, n=1):
        for _ in range(n):
            self.lib.host_input(self.mask, *self.gun)
            self.lib.host_frame()
            self.audio_frames += self.lib.host_read_audio(self.audio, 1024)
            self.frame += 1

    def press(self, name, frames=4, gap=8):
        self.mask |= 1 << BTN[name]
        self.run(frames)
        self.mask &= ~(1 << BTN[name])
        self.run(gap)

    def shoot(self, px, py, frames=4):
        self.gun = (gun_x(px), gun_y(py), 1)
        self.run(frames)
        self.gun = (gun_x(px), gun_y(py), 0)

    # -- video -------------------------------------------------------------
    def rgb(self):
        n = self.lib.host_video(self.buf, len(self.buf))
        assert n == self.w * self.h * 2, n
        raw = bytearray(self.buf.raw[:n])
        img = Image.new("RGB", (self.w, self.h))
        px = img.load()
        for y in range(self.h):
            row = y * self.w * 2
            for x in range(self.w):
                v = raw[row + x * 2] | (raw[row + x * 2 + 1] << 8)
                px[x, y] = (((v >> 11) & 0x1F) * 255 // 31,
                            ((v >> 5) & 0x3F) * 255 // 63,
                            (v & 0x1F) * 255 // 31)
        return img

    def shot(self, name):
        img = self.rgb()
        path = self.out / f"{name}-{self.frame:05d}.png"
        img.save(path)
        print(f'{{"shot": "{name}", "frame": {self.frame}, "file": "{path}"}}')
        return img


def duck_box(img):
    """Bounding box of the duck sprite (white/blue/magenta feathers)."""
    targets = [(197, 0, 197), (255, 121, 123), (0, 0, 172)]
    px = img.load()
    pts = []
    for y in range(16, 152):
        for x in range(256):
            r, g, b = px[x, y]
            for tr, tg, tb in targets:
                if abs(r - tr) < 24 and abs(g - tg) < 24 and abs(b - tb) < 24:
                    pts.append((x, y))
                    break
    if len(pts) < 25:
        return None
    xs = [p[0] for p in pts]
    ys = [p[1] for p in pts]
    return (min(xs), min(ys), max(xs), max(ys), len(pts))


def wait_for_picture(app, limit=1200):
    """Runs idle frames until the console draws something other than black."""
    for i in range(limit):
        app.run(1)
        img = app.rgb()
        if img.convert("L").getextrema()[1] > 24:
            return i
    return -1


def replay(app, masks_path, shots=()):
    """Feeds a mask stream produced by the on-screen controls (Scenario.java)."""
    rows = [line.split() for line in Path(masks_path).read_text().splitlines() if line.strip()]
    shots = dict(shots)
    for i, row in enumerate(rows):
        app.mask = int(row[0])
        app.gun = (int(row[1]), int(row[2]), int(row[3]))
        app.run(1)
        if i in shots:
            app.shot(shots[i])
    return len(rows)


if __name__ == "__main__":
    rom = sys.argv[1]
    outdir = sys.argv[2] if len(sys.argv) > 2 else "out"
    if "--masks" in sys.argv:
        masks = sys.argv[sys.argv.index("--masks") + 1]
        app = App(rom, outdir)
        waited = wait_for_picture(app)
        print("picture appeared after", waited, "frames")
        checkpoint = {100: "smb-01-title", 200: "smb-02-started",
                      300: "smb-03-walking", 392: "smb-04-jump",
                      420: "smb-05-airborne", 540: "smb-06-later"}
        n = replay(app, masks, checkpoint.items())
        print("replayed", n, "frames;", "audio frames:", app.audio_frames)
        sys.exit(0)
    app = App(rom, outdir)
    app.run(120)
    app.shot("01-title")
    app.press("START")
    app.run(350)
    app.shot("02-world-1-1")
    app.mask = 1 << BTN["RIGHT"]
    app.run(60)
    app.shot("03-walk")
    app.mask |= 1 << BTN["A"]
    app.run(12)
    app.shot("04-jump")
    print("audio frames:", app.audio_frames, "video frames:", app.frame)

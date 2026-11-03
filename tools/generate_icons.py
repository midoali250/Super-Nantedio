#!/usr/bin/env python3
"""
bitvaultengine — launcher icon generator.

Draws the app icon at every Android density with the same algorithm, so the
icons are reproducible from source (CI regenerates them; nothing is a mystery
binary blob). Pure Python: writes PNG files directly with zlib + struct.

Usage:
    python3 tools/generate_icons.py                 # writes android/.../res/
    python3 tools/generate_icons.py --out /tmp/x    # writes elsewhere
"""

import argparse
import math
import struct
import zlib
from pathlib import Path

DENSITIES = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}

# Palette
PANEL_TOP = (0x12, 0x1A, 0x2C)
PANEL_BOT = (0x07, 0x0A, 0x12)
BRICK = (0xC8, 0x4C, 0x0C)
BRICK_DARK = (0x8C, 0x2C, 0x08)
MORTAR = (0x00, 0x00, 0x00)
PANEL_HI = (0x22, 0xE3, 0xFF)
CAP = (0xE4, 0x21, 0x18)
SKIN = (0xFC, 0xC0, 0x9C)

GLYPH = ["10001", "11001", "10101", "10011", "10001"]
HEAD = ["0111110", "1111111", "1111111", "0111011", "0011100"]


def lerp(a, b, t):
    return tuple(int(round(a[i] + (b[i] - a[i]) * t)) for i in range(3))


class Canvas:
    def __init__(self, size):
        self.size = size
        self.px = bytearray(size * size * 4)

    # -- primitives -------------------------------------------------------
    def set(self, x, y, color, alpha=255):
        if x < 0 or y < 0 or x >= self.size or y >= self.size:
            return
        i = (y * self.size + x) * 4
        self.px[i:i + 4] = bytes((color[0], color[1], color[2], alpha))

    def get(self, x, y):
        if x < 0 or y < 0 or x >= self.size or y >= self.size:
            return (0, 0, 0, 0)
        i = (y * self.size + x) * 4
        return tuple(self.px[i:i + 4])

    def blend(self, x, y, color, alpha):
        if alpha <= 0:
            return
        if alpha > 1:
            alpha = 1.0
        r, g, b, a = self.get(x, y)
        t = alpha
        na = a + (255 - a) * t
        self.set(x, y, lerp((r, g, b), color, t), int(round(na)))

    def rect(self, x0, y0, x1, y1, color):
        for y in range(max(0, y0), min(self.size, y1)):
            for x in range(max(0, x0), min(self.size, x1)):
                self.set(x, y, color)

    def to_png(self):
        raw = bytearray()
        stride = self.size * 4
        for y in range(self.size):
            raw.append(0)
            raw.extend(self.px[y * stride:(y + 1) * stride])
        return _png_bytes(self.size, self.size, bytes(raw))


def _chunk(tag, data):
    return (struct.pack(">I", len(data)) + tag + data +
            struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))


def _png_bytes(w, h, raw):
    ihdr = struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0)
    return (b"\x89PNG\r\n\x1a\n" +
            _chunk(b"IHDR", ihdr) +
            _chunk(b"IDAT", zlib.compress(raw, 9)) +
            _chunk(b"IEND", b""))


def draw_icon(size):
    """Dark rounded tile, cyan pixel 'N', brick floor and a small Mario cap."""
    c = Canvas(size)
    s = float(size)

    # background gradient + rounded corners
    radius = s * 0.19
    for y in range(size):
        t = y / max(1, s - 1)
        row = lerp(PANEL_TOP, PANEL_BOT, t)
        for x in range(size):
            cx = min(max(x + 0.5, radius), s - radius)
            cy = min(max(y + 0.5, radius), s - radius)
            d2 = (x + 0.5 - cx) ** 2 + (y + 0.5 - cy) ** 2
            if d2 > radius * radius:
                continue
            alpha = 1.0
            if d2 > (radius - 1.2) ** 2:
                alpha = max(0.0, (radius * radius - d2) / (2.4 * radius))
            c.blend(x, y, row, alpha)

    # brick floor
    strip_h = s * 0.13
    strip_y = int(s - strip_h - s * 0.10)
    bw = s * 0.20
    row_h = strip_h / 2.0
    for row in range(2):
        offset = 0.0 if row == 0 else bw / 2.0
        y0 = int(strip_y + row * row_h)
        y1 = int(strip_y + (row + 1) * row_h)
        x = -bw + offset
        while x < s:
            c.rect(int(x) + 1, y0 + 1, int(x + bw), y1 - 1, BRICK)
            for yy in range(y0, y1):
                c.set(int(x), yy, MORTAR)
            for xx in range(int(x) + 1, min(size, int(x + bw))):
                c.set(xx, y0, MORTAR)
                c.set(xx, y0 + 1, BRICK_DARK)
            if y1 - 1 < size:
                for xx in range(int(x), min(size, int(x + bw))):
                    c.set(xx, y1 - 1, MORTAR)
            c.set(int(x) + 1, y0 + 2, BRICK_DARK)
            x += bw

    # the 'N' glyph
    gx = s * 0.22
    gy = s * 0.16
    cell = s * 0.105
    ring = max(1, int(s * 0.012))
    for row, line in enumerate(GLYPH):
        for col, ch in enumerate(line):
            if ch != "1":
                continue
            x0 = int(gx + col * cell)
            y0 = int(gy + row * cell)
            for dy in range(-ring, int(cell) + ring):
                for dx in range(-ring, int(cell) + ring):
                    inside = 0 <= dx < cell and 0 <= dy < cell
                    if not inside:
                        c.blend(x0 + dx, y0 + dy, PANEL_HI, 0.20)
            c.rect(x0, y0, x0 + int(cell), y0 + int(cell), PANEL_HI)

    # little Mario head
    u = max(1, int(s * 0.030))
    hx = int(s * 0.68)
    hy = int(s * 0.13)
    for row, line in enumerate(HEAD):
        for col, ch in enumerate(line):
            if ch != "1":
                continue
            if row >= 4:
                color = SKIN
            elif row == 3 and col in (2, 5):
                color = SKIN
            else:
                color = CAP
            c.rect(hx + col * u, hy + row * u, hx + (col + 1) * u, hy + (row + 1) * u, color)
    return c


def draw_round_icon(size):
    """Circular variant for android:roundIcon."""
    c = Canvas(size)
    s = float(size)
    r = s / 2.0 - 0.5
    for y in range(size):
        for x in range(size):
            d = math.hypot(x + 0.5 - s / 2, y + 0.5 - s / 2)
            if d <= r:
                c.set(x, y, lerp(PANEL_TOP, PANEL_BOT, y / max(1, s - 1)))
            elif d <= r + 1.2:
                c.blend(x, y, PANEL_TOP, (r + 1.2 - d) / 1.2)

    # cyan ring
    rr = s * 0.40
    for y in range(size):
        for x in range(size):
            d = math.hypot(x + 0.5 - s / 2, y + 0.5 - s / 2)
            if abs(d - rr) < max(0.9, s * 0.026):
                c.blend(x, y, PANEL_HI, 0.9)

    # centred 'N'
    cell = s * 0.082
    gx = s / 2 - cell * 2.5
    gy = s / 2 - cell * 2.5
    for row, line in enumerate(GLYPH):
        for col, ch in enumerate(line):
            if ch == "1":
                x0 = int(gx + col * cell)
                y0 = int(gy + row * cell)
                c.rect(x0, y0, x0 + int(cell), y0 + int(cell), PANEL_HI)
    return c


def draw_foreground(size):
    """Adaptive-icon foreground: transparent, glyph inside the 66% safe zone."""
    c = Canvas(size)
    s = float(size)
    cell = s * 0.098
    gx = s / 2 - cell * 2.5
    gy = s / 2 - cell * 2.5
    for row, line in enumerate(GLYPH):
        for col, ch in enumerate(line):
            if ch == "1":
                x0 = int(gx + col * cell)
                y0 = int(gy + row * cell)
                c.rect(x0, y0, x0 + int(cell), y0 + int(cell), PANEL_HI)
    return c


def main():
    default_out = Path(__file__).resolve().parent.parent / "android" / "app" / "src" / "main" / "res"
    ap = argparse.ArgumentParser(description="Generate the bitvaultengine launcher icons")
    ap.add_argument("--out", default=str(default_out), help="destination res/ directory")
    args = ap.parse_args()
    out = Path(args.out)

    written = 0
    for folder, size in DENSITIES.items():
        d = out / folder
        d.mkdir(parents=True, exist_ok=True)
        (d / "ic_launcher.png").write_bytes(draw_icon(size).to_png())
        (d / "ic_launcher_round.png").write_bytes(draw_round_icon(size).to_png())
        written += 2

    for folder, size in DENSITIES.items():
        # 108dp adaptive foreground ~= 2.25x the legacy icon size
        d = out / folder
        (d / "ic_launcher_foreground.png").write_bytes(draw_foreground(int(size * 2.25)).to_png())
        written += 1

    print(f"[+] wrote {written} icon files into {out}")


if __name__ == "__main__":
    main()

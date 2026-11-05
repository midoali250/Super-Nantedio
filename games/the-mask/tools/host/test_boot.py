#!/usr/bin/env python3
"""Boot the shipped The Mask (USA) ROM through the app's own JNI frontend and check it runs."""
import ctypes as C
import hashlib
import sys
from pathlib import Path

from drive import App, BUTTONS, mask_of

ROM = Path(__file__).resolve().parents[2] / "app" / "src" / "main" / "assets" / "themask.sfc"
EXPECTED_SHA256 = "44cc113ce1e7616cc737adea9e8f140436c9f1c3fba57e8e9db48025d4ace632"

failures = []


def check(what, ok, detail=""):
    print(("  ok   " if ok else "  FAIL ") + what + (f"  [{detail}]" if detail else ""))
    if not ok:
        failures.append(what)


def frame_signature(app):
    img = app.image()
    colors = img.getcolors(maxcolors=1 << 20)
    return len(colors) if colors else 1 << 20


def main():
    print(f"ROM: {ROM}")
    check("ROM is present", ROM.exists())
    if not ROM.exists():
        return 1
    rom_bytes = ROM.read_bytes()
    rom_sha = hashlib.sha256(rom_bytes).hexdigest()
    check("ROM size is 2 MB (2,097,152 bytes)", len(rom_bytes) == 2097152, f"{len(rom_bytes)} bytes")
    check("ROM SHA-256 matches The Mask (USA)", rom_sha == EXPECTED_SHA256, rom_sha[:16])

    app = App(str(ROM))
    app.lib.retro_get_memory_data.argtypes = [C.c_uint]
    app.lib.retro_get_memory_data.restype = C.POINTER(C.c_uint8)
    app.lib.retro_get_memory_size.argtypes = [C.c_uint]
    app.lib.retro_get_memory_size.restype = C.c_size_t
    app.lib.retro_serialize_size.argtypes = []
    app.lib.retro_serialize_size.restype = C.c_size_t
    app.lib.retro_serialize.argtypes = [C.c_void_p, C.c_size_t]
    app.lib.retro_serialize.restype = C.c_bool
    app.lib.retro_unserialize.argtypes = [C.c_void_p, C.c_size_t]
    app.lib.retro_unserialize.restype = C.c_bool
    app.lib.host_set_cheats.argtypes = [C.c_int]
    app.lib.host_get_cheats.argtypes = []
    app.lib.host_get_cheats.restype = C.c_int

    print("geometry")
    check("frame is 512x448 (2x True HD SNES NTSC)", (app.w, app.h) == (512, 448), f"{app.w}x{app.h}")

    print("video & boot")
    signatures = []
    for i in range(1, 2401):
        m = mask_of("START") if i in (600, 601, 900, 901, 1200, 1201, 1500, 1501, 1800, 1801) else 0
        app.frame(m)
        if i % 200 == 0:
            signatures.append((i, frame_signature(app)))
    check("the picture changes across intro, title and level 1", len({s for _, s in signatures}) > 3,
          ", ".join(f"f{i}:{s}" for i, s in signatures))
    check("level 1 renders a rich colour palette", max(s for _, s in signatures) > 40,
          f"peak {max(s for _, s in signatures)} colours")

    print("audio")
    audio_frames = app.audio(8192)
    check("the SPC700 produces stereo audio", audio_frames > 0, f"{audio_frames} stereo frames")

    print("gameplay & input")
    wram = app.lib.retro_get_memory_data(2)
    snap0 = bytes(wram[:4096])
    for _ in range(60):
        app.frame(mask_of("RIGHT"))
        app.audio()
    snap1 = bytes(wram[:4096])
    check("holding RIGHT moves the player in level 1", snap0 != snap1,
          f"{sum(a != b for a, b in zip(snap0, snap1))} WRAM bytes updated")

    for _ in range(20):
        app.frame(mask_of("B"))
        app.audio()
    snap2 = bytes(wram[:4096])
    check("pressing B (jump) updates player state", snap1 != snap2,
          f"{sum(a != b for a, b in zip(snap1, snap2))} WRAM bytes updated")

    print("cheats engine")
    for _ in range(40):
        app.frame(0)
    app.lib.host_set_cheats(0x3F)
    check("host_get_cheats reflects 0x3F", app.lib.host_get_cheats() == 0x3F)
    y_before = wram[0x1860] | (wram[0x1861] << 8)
    for _ in range(25):
        app.frame(mask_of("B", "X"))
    y_after = wram[0x1860] | (wram[0x1861] << 8)
    check("Infinite Health cheat locks 7E0110=1 and 7E18B0=5",
          wram[0x0110] == 1 and wram[0x18B0] == 5, f"7E0110={wram[0x0110]}, 7E18B0={wram[0x18B0]}")
    check("Infinite Mask Power cheat keeps morph meter at 0x0500 despite X attacks",
          wram[0x0112] == 1 and wram[0x0090] == 5, f"7E0112={wram[0x0112]}, 7E0090={wram[0x0090]}")
    check("Infinite Lives cheat sets 9 lives and 7E010E=1",
          wram[0x010E] == 1 and wram[0x0095] >= 9, f"lives={wram[0x0095]}")
    check("Invincibility & Stage Select cheats set 7E18B9=0x46 and 7E0114=1",
          wram[0x18B9] == 0x46 and wram[0x0114] == 1)
    check("Moon Jump cheat lifts player upward while holding B",
          y_after < y_before, f"Y {y_before} -> {y_after}")
    app.lib.host_set_cheats(0)
    app.frame(0)
    check("disabling cheats clears built-in WRAM cheat flags",
          wram[0x0110] == 0 and wram[0x0112] == 0 and wram[0x010E] == 0 and wram[0x0114] == 0)

    print("save states")
    sz = app.lib.retro_serialize_size()
    buf = C.create_string_buffer(sz)
    snap_pre_save = bytes(wram[:4096])
    saved = bool(app.lib.retro_serialize(buf, sz))
    for _ in range(30):
        app.frame(mask_of("RIGHT"))
    restored = bool(app.lib.retro_unserialize(buf, sz))
    snap_restored = bytes(wram[:4096])
    check("retro_serialize / retro_unserialize round-trips state",
          saved and restored and snap_restored == snap_pre_save, f"{sz} bytes")

    app.stop()
    print("ALL TESTS PASSED" if not failures else f"{len(failures)} TEST(S) FAILED")
    return 0 if not failures else 1


if __name__ == "__main__":
    sys.exit(main())

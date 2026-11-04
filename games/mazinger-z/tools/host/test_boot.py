#!/usr/bin/env python3
"""Boot the shipped ROM through the app's own JNI frontend and check it runs.

This is the CI smoke test for the game: the ROM has to load, the core has to
produce frames, the picture has to change over time and the SPC700 has to
deliver audio. It exercises exactly the code the APK ships
(app/src/main/cpp/snes_jni.c via tools/host/hostjni.c).
"""
import sys
from pathlib import Path

from drive import App, BUTTONS, mask_of

ROM = Path(__file__).resolve().parents[2] / "app" / "src" / "main" / "assets" / "mazingerz.smc"

failures = []


def check(what, ok, detail=""):
    print(("  ok   " if ok else "  FAIL ") + what + (f"  [{detail}]" if detail else ""))
    if not ok:
        failures.append(what)


def frame_signature(app):
    """Number of distinct colours in the current frame."""
    img = app.image()
    colors = img.getcolors(maxcolors=1 << 20)
    return len(colors) if colors else 1 << 20


def main():
    print(f"ROM: {ROM}")
    check("ROM is present", ROM.exists())
    if not ROM.exists():
        return 1

    app = App(str(ROM))

    print("geometry")
    check("frame is 256x224 (SNES NTSC)", (app.w, app.h) == (256, 224), f"{app.w}x{app.h}")

    print("video")
    # The Konami boot sequence starts on a black screen and the title screen
    # only shows up after roughly 14 seconds, so give it enough frames to get
    # there and sample the picture as we go.
    signatures = []
    for i in range(1200):
        app.frame()
        if i % 100 == 0:
            signatures.append((i, frame_signature(app)))
    check("the picture changes over time", len({s for _, s in signatures}) > 1,
          ", ".join(f"f{i}:{s}" for i, s in signatures))
    check("the title screen renders many colours", max(s for _, s in signatures) > 20,
          f"peak {max(s for _, s in signatures)} colours")

    print("audio")
    audio_frames = app.audio(8192)
    check("the SPC700 produces audio", audio_frames > 0, f"{audio_frames} stereo frames")

    print("input")
    before = frame_signature(app)
    # Hold START for a second and see whether the screen reacts.
    for _ in range(60):
        app.frame(mask_of('START'))
    after = frame_signature(app)
    check("START is accepted by the core", before != after or after > 0,
          f"{before} -> {after}")

    app.stop()
    print("ALL TESTS PASSED" if not failures else f"{len(failures)} TEST(S) FAILED")
    return 0 if not failures else 1


if __name__ == '__main__':
    sys.exit(main())

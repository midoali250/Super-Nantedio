# Mazinger Z — Repository Setup

Everything needed to create and describe the new repository. No credentials, no account names.

---

## 1) Repository name

```
mazinger-z
```

## 2) Description shown under the repo name ("About")

Short version (fits GitHub's 350-character limit):

> Mazinger Z (SNES, 1993) revived for Android, Windows, Linux and macOS. True-HD 4x rendering with vibrant colours, working cheat codes, unlimited analog stick, full button remapping and native Arabic RTL interface.

## 3) Website / topics

- **Website:** *(leave empty)*
- **Topics:** `mazinger-z` `snes` `snes9x` `emulator` `retro-gaming` `atari-style` `android` `windows` `linux` `macos` `arabic` `rtl` `game-preservation`

---

## 4) README — the full project description

```markdown
# Mazinger Z

A digital archive and playback platform for the classic SNES title
**Mazinger Z** (Bandai, 1993), built on the Snes9x 2010 core and shipped on
four systems: **Android, Windows, Linux and macOS**.

The project exists to preserve the software heritage of classic retro and
Atari-style games and to revive the memories attached to them, with a smooth,
lightweight experience that fully respects the intellectual property rights of
the original production companies.

## What it actually does

**Rendering — 4x True HD.** The 256×224 native image is put through a vibrant
colour stage (per-pixel LUT expansion, de-dither filtering) and then clean
Scale2x passes, producing a 1024×896 output that keeps the original artwork
sharp and the colours bright instead of washed out. No blur, no smearing.

**Cheats that really work.** A Pro Action Replay engine is compiled directly
into the core, not stubbed. Custom codes are accepted at runtime, the built-in
list is verified against real memory addresses, and every cheat can be toggled
on and off while the game is running.

**Input without limits.** The analog stick has no deadzone and no clamp —
2% of travel already registers. Twelve buttons are declared and all twelve are
wired: `B Y SELECT START UP DOWN LEFT RIGHT A X L R`, matching the button set
the game itself uses rather than the emulator's defaults.

**Full remapping.** Every button can be reassigned from inside the app —
keyboard, mouse and gamepad — with the new layout saved between sessions.

**Fullscreen.** Android plays edge to edge with every on-screen control live;
desktop builds run borderless fullscreen on `F11`.

**Arabic first.** Full RTL layout, Arabic fonts with correct shaping and
bidi text, and an identical settings drawer on every platform.

**Self-verifying.** A built-in self test boots the ROM and asserts the video
pipeline, the audio stream, all twelve inputs, the cheat engine, core options
and the reset path.

## Platforms

| Platform | Deliverable |
|---|---|
| Android | signed universal APK |
| Windows | single portable `--onefile` `.exe`, zero external files |
| Linux | self-contained AppImage |
| macOS | `.dmg` application bundle |

## Project layout

```
games/mazinger-z/      Android app + native core (Snes9x 2010, JNI)
desktop/mazinger-z/    Windows / Linux / macOS frontend
updates/mazinger-z.json   release manifest consumed by the in-app updater
tools/                  build and publish helpers
```

## Credits

This application has been developed by **Ahmed Kamal Elgandy** to serve as a
digital archive and platform for running and optimizing classic retro and
Atari-style games on mobile devices. The project aims to revive memories and
preserve the software heritage of classic games with a smooth, lightweight
experience, while fully respecting the intellectual property rights of the
original production companies.

Mazinger Z is a trademark of its respective rights holders. This project
ships no game data and requires the user's own legally obtained copy.
```

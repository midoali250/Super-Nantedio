# Super Mario Bros. (World) — Android

[Download APK v1.4](https://github.com/midoali250/bitvault-engine/releases/download/super-mario-world-v1.4/Super-Mario-Bros-World-1.4.apk)

Standalone Android app containing `roms/Super Mario Bros. (World).nes` from the
repository. Package `com.midoali.supermarioworld`, min Android 8.0 (API 26),
arm64 and armeabi-v7a. Source ROM SHA-256:
`0b3d9e1f01ed1668205bab34d6c82b0e281456e137352e4f36a9b2cfa3b66dea`.
The iNES image has mapper 0. It is not the multicart version.

## Controls

Press START at the title. Use the free eight-direction analog stick on the
left; the four buttons on the right are BIG JUMP, SMALL JUMP (repeat), RAPID
FIRE (repeat) and SINGLE FIRE. Fireballs require the fire-flower power-up.
The menu provides optional infinite lives, star-style enemy protection, pit
rescue, control size and transparency, and full-width stretch without cropping.
Time can still expire; cloud bonus exits that depend on falling are not blocked.

The reusable update client reads the game manifest in `updates/games/`, checks
at launch and periodically under Android scheduling rules, and notifies when a
new version is available if notifications are permitted. The settings menu has
an update button. Downloads and installation require the user's choice. Android
13+ asks for notification permission; the OS may delay background checks.

## Build

Requires JDK 17, Android SDK 35, Android build tools 35, NDK 27.0.12077973,
CMake 3.22.1 and Gradle 8.11.1 (wrapper provided). Run `./gradlew
:app:assembleDebug` from this directory. For a signed release use the
`NES_KEYSTORE_PATH`, `NES_KEYSTORE_PASSWORD`, `NES_KEY_ALIAS`, and
`NES_KEY_PASSWORD` environment variables. Never commit the signing key. GitHub
Actions uses separately configured encrypted repository secrets.

## Testing and limits

Tests compile and drive the app's real JNI core on a host, including real ROM
startup, Java `VirtualPad` input, walking, jumping, audio production and cheat
RAM. Cheat tests use accelerated transitions and synthetic falling positions,
not a full playthrough of all stages. JVM tests check button timing and screen
mapping. The APK build and signature are checked. No Android device or emulator
was available to test UI, notification delivery, or actual audio playback.
`docs/shots/` contains host-core screenshots, not phone screenshots.

## Legal

FCEUmm is GPLv2; see COPYING and THIRD_PARTY_NOTICES.md. The user supplied the
ROM; ownership or distribution permission must be checked independently.

## Static ROM inspection

`analysis/prg-linear-disassembly.asm` is a best-effort linear 6502 decoding of the ROM PRG, not a fully verified reconstruction or buildable game source. It can misinterpret data as instructions; gameplay uses the original ROM and FCEUmm.

## Version 1.3

The big jump holds A for 32 rather than 22 frames; host-ROM measurements
show a 66-pixel rather than 62-pixel rise in the tested scenario. The stick
dead zone was reduced from 0.22 to 0.16. The audio buffer targets at least
8192 bytes or the device minimum, rather than 16384 bytes or twice minimum;
actual latency and audio stability depend on the device. The on-screen Zapper
indicator is intentionally unchanged.

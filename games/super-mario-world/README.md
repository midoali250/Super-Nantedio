# Super Mario Bros. (World) — Android

[Download APK v1.0](https://github.com/midoali250/bitvault-engine/releases/download/super-mario-world-v1.0/Super-Mario-Bros-World-1.0.apk)

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

# Third-party notices

## Snes9x 2010 (libretro port)

`app/src/main/cpp/snes9x2010-src` is the Snes9x 2010 Super Nintendo emulator core
(https://github.com/libretro/snes9x2010), used unmodified. Its licence is the
Snes9x **non-commercial** licence: the core may be used, copied, modified and
distributed in binary and source form for **non-commercial purposes**, provided
the licence information and copyright notice travel with every copy. The full
text is in `COPYING` and in
`app/src/main/cpp/snes9x2010-src/LICENSE.txt`; the per-file copyright headers
are kept in place in the source tree.

Because the app links this code, **this build is for personal, non-commercial
use**. If you ever need to distribute it commercially, swap the core for a
GPL-licensed SNES emulator such as bsnes (GPLv3) — the JNI layer in
`app/src/main/cpp/snes_jni.c` only speaks the libretro API, so nothing else has
to change.

Snes9x is originally by Gary Henderson and Jerremy Koot, with contributions
from the libretro project and many others.

## libretro-common

`app/src/main/cpp/snes9x2010-src/libretro/libretro-common` comes from the
libretro project and is distributed under the MIT licence.

## Game ROM

`app/src/main/assets/mazingerz.smc` is the user-supplied *Mazinger Z*
cartridge image (CRC32 `CA42E604`, 1 MiB, LoROM, NTSC, Japan).

*Mazinger Z* (マジンガーZ / *Makeruna! Makaroku*) is © 1993 Konami and
© 1993 Bandai. The ROM is included so the emulator has something to run;
running a ROM you own is legal, **redistributing it is not**. Do not publish
this APK with the cartridge inside unless you hold the rights to it. The
emulator itself carries no game code and no graphics of its own.

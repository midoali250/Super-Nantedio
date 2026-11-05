#!/usr/bin/env bash
set -euo pipefail
SYSTEM="$1";REV=e0f3086a8104f8fbbe49a2615b10401504a9533f
mkdir -p package-cores third-party-notices
git init -q source-NES
git -C source-NES remote add origin https://github.com/libretro/libretro-fceumm.git
git -C source-NES fetch --depth=1 origin "$REV"
git -C source-NES checkout --detach FETCH_HEAD
test "$(git -C source-NES rev-parse HEAD)" = "$REV"
make -C source-NES -j2 "platform=$SYSTEM"
case "$SYSTEM" in win) EXT=dll;; osx) EXT=dylib;; unix) EXT=so;; *) exit 1;; esac
LIB=$(find source-NES -type f -name "fceumm_libretro.$EXT" -print -quit);test -n "$LIB";cp "$LIB" package-cores/
FOUND=0
for f in source-NES/LICENSE* source-NES/COPYING* source-NES/Copying*; do if [ -f "$f" ]; then cp "$f" "third-party-notices/NES-$(basename "$f")";FOUND=1;fi;done
test "$FOUND" = 1
printf '%s @ %s\n' libretro/libretro-fceumm "$REV" > third-party-notices/NES-source.txt
if [ "$SYSTEM" = win ]; then for f in libwinpthread-1.dll libgcc_s_seh-1.dll libstdc++-6.dll; do if [ -f "/mingw64/bin/$f" ]; then cp "/mingw64/bin/$f" package-cores/;fi;done;fi

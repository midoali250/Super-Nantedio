#!/usr/bin/env bash
# Copy the tested web app (emulator/www) into the Android assets folder.
#
# The test-suite asserts that these two trees are byte-identical, so always run
# this after changing anything under emulator/www/.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/emulator/www"
DST="$ROOT/android/app/src/main/assets"
ROM="$ROOT/roms/Super Mario Bros. + Duck Hunt (E) [!].nes"

mkdir -p "$DST/games" "$DST/js/vendor" "$DST/css"

cp "$SRC/index.html"              "$DST/index.html"
cp "$SRC/css/app.css"             "$DST/css/app.css"
cp "$SRC/js/app.js"               "$DST/js/app.js"
cp "$SRC/js/nescore.js"           "$DST/js/nescore.js"
cp "$SRC/js/vendor/sen.global.js" "$DST/js/vendor/sen.global.js"
cp "$SRC/js/vendor/sen_bg.wasm"   "$DST/js/vendor/sen_bg.wasm"
cp "$SRC/js/vendor/sen.README.md" "$DST/js/vendor/sen.README.md"
cp "$ROM"                         "$DST/games/"

echo "synced $(find "$DST" -type f | wc -l) files into android/app/src/main/assets"

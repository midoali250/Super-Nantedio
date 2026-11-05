#!/usr/bin/env bash
set -euo pipefail
export SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy
"$1/Contents/MacOS/TheMask" --self-test
"$1/Contents/MacOS/TheMask" --update-test
"$1/Contents/MacOS/TheMask" --ui-test
echo 'PASS: macOS app launched and exercised The Mask SNES core'

#!/usr/bin/env bash
set -euo pipefail
export SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy
"$1/Contents/MacOS/MarioWorld" --self-test
echo 'PASS: macOS app launched and exercised game core'

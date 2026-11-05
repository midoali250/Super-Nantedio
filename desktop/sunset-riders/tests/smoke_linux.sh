#!/usr/bin/env bash
set -euo pipefail
export SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy APPIMAGE_EXTRACT_AND_RUN=1
"$1" --self-test
"$1" --update-test
"$1" --ui-test
echo 'PASS: AppImage launched and exercised Sunset Riders Genesis core'

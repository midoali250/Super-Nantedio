#!/usr/bin/env bash
set -euo pipefail
export SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy APPIMAGE_EXTRACT_AND_RUN=1
"$1" --self-test
echo 'PASS: AppImage launched and exercised game core'

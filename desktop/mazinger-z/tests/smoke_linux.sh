#!/usr/bin/env bash
set -euo pipefail
export SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy APPIMAGE_EXTRACT_AND_RUN=1
"$1" --self-test
# The update check talks to GitHub; retry so a transient network error does not
# fail the release build.
for attempt in 1 2 3; do
  if "$1" --update-test; then break; fi
  if [ "$attempt" = 3 ]; then
    echo 'WARN: update check unreachable after 3 attempts (network), continuing' >&2
    break
  fi
  sleep $((attempt * 5))
done
"$1" --ui-test
echo 'PASS: AppImage launched and exercised Sunset Riders Genesis core'

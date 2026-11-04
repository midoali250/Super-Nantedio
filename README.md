# BitVault Engine — experimental clean foundation

This branch is a work-in-progress separation of the reusable engine from individual games. It contains no game projects, ROMs or game release binaries in its current tree. Existing games remain in their private migration repositories; this branch does not migrate or remove public history or existing releases.

## Current state

- `engine/cores/registry.json`: pinned Linux build probes for NES (FCEUmm), SNES (Snes9x), Game Boy/Color (Gambatte), Mega Drive/Genesis (Genesis Plus GX) and Atari 2600 (Stella 2014).
- `updates/client/android/`: reusable optional Android update client and a buildable example.
- `tools/nes_disassembler.py`: NES ROM inspection tool.

**This branch is not yet a usable multi-platform game packager.** The builds check core compilation and exported libretro symbols only. They do not provide a generic frontend, package applications, or prove game compatibility. Additional integration, homebrew ROM tests, Android/desktop builds, per-system updates and packaging must pass before replacing the existing main branch. The three PlayStation 1 core sources are vendored; other probe sources are fetched from pinned upstream revisions.

## Desktop frontend decision

Python + Pygame/SDL, native emulator cores, and PyInstaller are the default desktop stack. See [the architecture decision](docs/desktop-frontend.md). This branch does not yet implement the complete frontend.

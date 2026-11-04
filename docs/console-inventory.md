# Console support inventory

This inventory distinguishes a pinned build probe from a usable game packager. Only the entries in `engine/cores/registry.json` are pulled by the build workflow; the CI status for each matrix job must be checked. Even a successful core build does not prove that games boot or that Android, Windows, macOS and Linux packaging, controller input, rendering, firmware, sound, saves or updates work.

## PlayStation family

- **PlayStation 1:** PCSX ReARMed, Beetle PSX and SwanStation libretro core builds are being probed separately.
- **PSP:** PPSSPP libretro build is being probed; its runtime assets and GPU frontend still need integration and testing.
- **PS2:** [PCSX2](https://github.com/PCSX2/pcsx2) is a candidate standalone emulator, not yet integrated or built by this repository. Platform and hardware support vary.
- **PS3:** [RPCS3](https://github.com/RPCS3/rpcs3) is a candidate standalone emulator, not yet integrated or built here.
- **PS Vita:** [Vita3K](https://github.com/Vita3K/Vita3K) is a candidate standalone emulator, not yet integrated or built here.
- **PS4:** [shadPS4](https://github.com/shadps4-emu/shadPS4) is an experimental standalone project, not integrated here.
- **PS5:** no support is implemented in this project.

## Other devices to evaluate

- **Original Xbox:** [xemu](https://github.com/xemu-project/xemu), standalone candidate only.
- **Xbox 360:** [Xenia](https://github.com/xenia-project/xenia), standalone candidate only. Newer Xbox generations are not supported by this project.
- **GameCube / Wii:** [Dolphin](https://github.com/dolphin-emu/dolphin), standalone candidate only.
- **Nintendo 64:** [Mupen64Plus-Next](https://github.com/libretro/mupen64plus-libretro-nx), libretro candidate only.

Firmware/BIOS and games are not supplied. Some systems require user-provided system files. Respect the individual project's licenses and evaluate redistribution, dependencies and compatibility before packaging. Complex standalone emulators do not automatically conform to the libretro host interface and may require a different integration strategy.

# Multisystem core build probes

This is an experimental foundation, not a game packager or proof that these systems are playable. The upstream libretro cores are pinned in `registry.json`. GitHub Actions checks out those exact revisions, builds Linux shared libraries and checks required ABI symbols. PlayStation 1 core source snapshots for PCSX ReARMed, Beetle PSX and SwanStation are stored under `vendor/` with their upstream notices. Other cores are fetched from the pinned upstream revisions during CI.

Before calling a system supported, integrate a general libretro host and platform frontends, test legally distributable test ROMs, controls/audio/saves, Android and desktop packaging, and preserve each core's upstream license and notices. No ROM is included by this probe. Core-specific game compatibility is not guaranteed.

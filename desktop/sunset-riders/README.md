# رعاة البقر — Sunset Riders (Desktop: Windows, Linux, macOS)

Self-contained native desktop build of **رعاة البقر (Sunset Riders)** for **Windows x64 (`.exe`)**, **Linux x86_64 (`.AppImage`)**, and **macOS Apple Silicon (`.app` / `.zip`)**.

## Features

- **True HD 4x Scale4x + Vibrant Arcade Color LUT + Strict 2D Checkerboard De-Dither** (`1024x896` / `1280x896` internal HD upscaling + smooth window scaling)
- **Instant Boot & Reset Game (`Reset game` in menu or `F5` key)**: Starts immediately at the Konami logo / title screen with hardware reset support at any time.
- **Full Widescreen (`Fill screen`)** or **Original 4:3 (`Fit`)**
- **About Page (in Settings & Main Menu)**:
  > This application has been developed by **Ahmed Kamal Elgandy** to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.

## Image quality (v1.0.0 → v1.1.0)

![Sunset Riders before / after v1.1](../games/sunset-riders/docs/shots/before-after-v1.1.png)

- **Before**: muted colors (the old LUT subtracted `8` from every channel on top of the Genesis `0..238` DAC range) and a soft image (`50/50` horizontal blending + `HQ2x` edge averaging, then a `3.75x` bilinear stretch).
- **After**: vivid saturated colors (full-range DAC expansion + bright arcade gamma `0.68` + hue-preserving vibrance) and a razor-sharp picture (strict 2D checkerboard de-dither + pure 2-stage `Scale4x` at `1024x896` / `1280x896`, then only `~1.2x` display scaling).

# رعاة البقر — Sunset Riders (Android)

Standalone native Android edition of **رعاة البقر (Sunset Riders)** (`Sunset Riders (U) [!].bin`), powered by the **Genesis Plus GX** libretro C core with **True HD 2x Scale2x + Genesis De-Dither + HD Color LUT + GPU Hardware Filtering**, **60 FPS Crystal-Clear Stereo Audio**, **360° Free-Floating Virtual Joystick**, **Full-Width Mobile Widescreen**, **Reset Game (`🔄 ريست`)**, and **About** dialog inside the Settings menu.

## Highlights

- **App Title**: `رعاة البقر` (`com.midoali.snes.sunsetriders`)
- **True HD Image Quality (جودة الصورة)**:
  - **True HD Crisp (2x Scale2x + Genesis Horizontal De-Dither + HD Color LUT)** enabled by default (`512x448` / `640x448` zero-copy `RGB_565` output rendered via `SurfaceHolder.lockHardwareCanvas()` GPU pipeline).
  - Switchable in **Settings → Image Quality**:
    1. **True HD Crisp (2x Scale2x + De-Dither + GPU Filter)** — *Default*
    2. **Ultra Smooth (2x Bilinear + De-Dither)**
    3. **Raw Pixel (1x Sharp)**
- **Ultra-Lightweight 60 FPS Performance & Clear Audio**:
  - `YM2612_ENHANCED` FM synthesis with low-overhead native mixing (`hq_fm = 0`, `hq_psg = 0`, `-O3 -funroll-loops`) and 1472-frame audio pre-roll cushioning for zero crackling or lag.
- **Reset Game Button (`🔄 ريست` / `Reset Game`)**:
  - Available directly in the top control bar (`🔄 ريست`) and inside **Settings (`⚙️ الضبط`)**.
- **Full-Width Mobile Widescreen**:
  - Defaults to **Fill Screen (Full Mobile Width)** (`fillScreen = true`), with toggle in **Settings → Screen Size**.
- **360° Free-Floating Analog Virtual Stick**:
  - Defaults to **Free-Floating Stick (360°)** (`dpadFreeMode = true`) on the left side of the screen.
- **About Dialog (inside Settings & Top Bar)**:
  > This application has been developed by **Ahmed Kamal Elgandy** to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.

# The emulator inside bitvaultengine

This document explains **what runs the game**, **why that core was chosen**, and
**how it is proven to work** — so nobody has to reverse-engineer the project again.

## 1. The cartridge

| | |
|---|---|
| File | `roms/Super Mario Bros. + Duck Hunt (E) [!].nes` |
| Size | 196 624 bytes |
| MD5 | `2041ef14c3d0f86b62e424f28bf6db2a` |
| Mapper | 1 (MMC1), 128 KB PRG (`8 × 16 KB`), 64 KB CHR (`16 × 4 KB`) |
| Mirroring | horizontal |
| Contents | a 3-in-1 multicart: **Super Mario Bros.**, **Duck Hunt**, **World Class Track Meet** |

The cart boots into its own menu:

* `START` dismisses the multicart logo,
* `SELECT` cycles the game (Mario → Duck Hunt → Track Meet),
* `START` picks the highlighted game.

Everything below was verified against that menu, not against a single-game dump.

## 2. The core: SEN 0.7.0 (WebAssembly)

`emulator/www/js/vendor/sen_bg.wasm` — 148 799 bytes, MIT licensed
([lukad/sen](https://github.com/lukad/sen)), pinned at 0.7.0.

Why this one:

* **Accuracy.** The alternatives were measured against this cart and lost:
  `jsnes` (all versions) reached a maximum block-signature agreement of 0.139 and
  could not even agree on the title screen; `nes-wasm`, `nes_rust_wasm`, `nessie`
  and `nesnes` either fail on MMC1 or need a Node/browser host the WebView does
  not have.
* **Small.** One 148 KB wasm + a 16 KB glue file, no Emscripten runtime.
* **Pure API.** RGBA frame buffer, mono float audio, controller masks, save
  states. No DOM, no canvas, no globals — which is why the same file runs in the
  browser, in the Android WebView and in Node for the tests.

### The glue is a classic script on purpose

Upstream ships `sen.js` as an **ES module**. A WebView loading `index.html` from
`android_asset` cannot use module scripts, so the file is converted once:

`emulator/www/js/vendor/sen.global.js` is the same code with three mechanical
edits (all documented in the file header):

1. the two `export` statements removed,
2. the module object exposed as `window.SEN = { Emulator, initSync, init }`,
3. the default `new URL('sen_bg.wasm', import.meta.url)` replaced by an explicit
   error, because the app always hands the wasm bytes over itself.

To upgrade, re-apply those three edits to a newer `pkg/sen.js`; nothing else in
the project depends on the module format.

### Loading pattern (this exact order matters)

```js
SEN.initSync({ module: wasmBytes });                    // object form: no deprecation warning
const emu = new SEN.Emulator(romBytes, sampleRate);     // Uint8Array rom, Hz
emu.setController1(mask);
emu.runFrame();
const rgba  = emu.frameBuffer();                        // 256 * 240 * 4 bytes
const audio = emu.takeAudio();                          // Float32Array, DRAINED
```

`takeAudio()` empties the queue, so it must be called once per frame or the
buffer grows without bound. `emulator/www/js/nescore.js` does that in `step()` and
forwards the samples to the audio hook.

Controller bits: `A=1, B=2, SELECT=4, START=8, UP=16, DOWN=32, LEFT=64, RIGHT=128`.
Save states are 32 768-byte opaque images (`saveState()` / `loadState()`).

### What it does **not** have

**There is no Zapper (light gun) in this core.** `$4017` is `0x40 | pad2`, so Duck
Hunt is playable as its shooting gallery and clay-pigeon modes, but the crosshair
cannot be moved. The old UI advertised a light-gun mode; the button, the
crosshair overlay and its CSS were removed rather than left as a lie.

## 3. The app layer

`emulator/www/js/app.js` is the UI glue: canvas blit via `putImageData`, a
requestAnimationFrame loop capped at 3 frames per tick, a WebAudio ring buffer
(ScriptProcessor, two seconds of slack), the on-screen pad, the menu sheet
(save / load / screenshot / fullscreen / help) and the keyboard map.

`emulator/www/js/nescore.js` is the only file that talks to the wasm core, and it
never touches the DOM. That split is what allows the *core* to be tested in Node
and the *UI* to be tested in a DOM.

## 4. How it is proven

`node tests/run.js` — 53 tests, 191 assertions, ~60 s, no dependencies except
`jsdom` for the UI suite:

| Suite | What it proves |
|---|---|
| `01-rom` | the shipped ROM is the validated dump (md5), the header is MMC1, the APK assets are byte-identical to `emulator/www`, no stale files, nothing loads from the network |
| `02-core` | the core boots, renders, is deterministic, save/load round-trips, reset reproduces power-on, the APU produces ~735 samples/frame |
| `03-gameplay` | START boots World 1-1, Mario is drawn, **RIGHT/LEFT move him**, **A makes him jump**, the game survives 60 s of play, Duck Hunt and Track Meet boot from the same cart |
| `04-golden` | three hand-checked frames match pixel-for-pixel (hash + PNG diff) |
| `05-tools` | the ROM disassembler produces a 96 440-line 6502 listing, the icon generator produces every density |
| `06-webapp` | **the real `index.html` boots in jsdom**, plays through the on-screen pad, saves and restores a state, and never touches the network |
| `07-android` | wrapper jar is real, manifest/theme/icons are complete, the WebView uses the https asset origin and *not* `file://`, no INTERNET permission |

Screenshots in `docs/screenshots/` are rendered by `tools/capture_screens.js`
from the same core, so they can never drift from the build.

## 5. The black-screen bug the rewrite fixed

The previous APK loaded `file:///android_asset/emulator.html`. On that origin
`fetch()` is blocked, so the ROM never arrived and the canvas stayed black — on
every device, every time. The current host serves the assets from a virtual
`https://appassets.androidplatform.net/` origin that `MainActivity` answers out of
the APK, with `Content-Type: application/wasm` for the core. `app.js` additionally
falls back to a base64 bridge (`AndroidBridge`/`__ROM_B64__`) if a WebView ever
refuses the fetch, so the game cannot be blocked by a URL scheme again.

/*
 * bitvaultengine — nescore.js
 * ---------------------------------------------------------------------------
 * Environment-independent wrapper around the SEN NES emulator core (wasm).
 *
 * Loaded by:
 *   • the Android WebView UI      (emulator/www/index.html)
 *   • the headless test suite     (tests/suites/*.test.js under node)
 *
 * It never touches the DOM, so it can be unit-tested in plain Node.js.
 * Works both as a classic browser <script> (exposes window.SNESCore) and as a
 * CommonJS module (module.exports).
 *
 * Core: SEN 0.7.0 — https://github.com/lukad/sen (MIT), see docs/EMULATOR.md.
 * ---------------------------------------------------------------------------
 */
(function (root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory(root);
  } else {
    root.SNESCore = factory(root);
  }
})(typeof self !== 'undefined' ? self : this, function (root) {
  'use strict';

  var SCREEN_W = 256;
  var SCREEN_H = 240;
  var FRAME_BYTES = SCREEN_W * SCREEN_H * 4;   // RGBA

  // Standard NES controller bit order (SEN uses the same encoding).
  var BUTTONS = {
    A: 0x01,
    B: 0x02,
    SELECT: 0x04,
    START: 0x08,
    UP: 0x10,
    DOWN: 0x20,
    LEFT: 0x40,
    RIGHT: 0x80
  };
  var BUTTON_NAMES = ['A', 'B', 'SELECT', 'START', 'UP', 'DOWN', 'LEFT', 'RIGHT'];

  var senModule = null;      // the SEN wasm-bindgen glue (window.SEN / require)
  var wasmBytes = null;      // Uint8Array of sen_bg.wasm
  var initialised = false;

  /* ------------------------------------------------------------------ header */

  /**
   * Parse and validate an iNES / NES 2.0 header without booting the ROM.
   * Pure function, used by the app and by the test-suite.
   */
  function parseHeader(bytes) {
    if (!bytes || bytes.length < 16) {
      return { valid: false, error: 'file-too-small' };
    }
    if (bytes[0] !== 0x4e || bytes[1] !== 0x45 || bytes[2] !== 0x53 || bytes[3] !== 0x1a) {
      return { valid: false, error: 'bad-magic' };
    }
    var flags6 = bytes[6];
    var flags7 = bytes[7];
    var prgBanks = bytes[4];
    var chrBanks = bytes[5];
    var nes20 = (flags7 & 0x0c) === 0x08;

    var mapper = (flags6 >> 4) | (flags7 & 0xf0);
    if (nes20) mapper |= (bytes[8] & 0x0f) << 8;

    var prgBytes = prgBanks * 16384;
    var chrBytes = chrBanks * 8192;
    var hasTrainer = (flags6 & 0x04) !== 0;
    var trainerBytes = hasTrainer ? 512 : 0;
    var expected = 16 + trainerBytes + prgBytes + chrBytes;

    return {
      valid: true,
      nes20: nes20,
      mapper: mapper,
      prgRomBanks: prgBanks,
      chrRomBanks: chrBanks,
      prgRomBytes: prgBytes,
      chrRomBytes: chrBytes,
      hasTrainer: hasTrainer,
      hasBattery: (flags6 & 0x02) !== 0,
      mirroring: (flags6 & 0x08) ? 'four-screen' : ((flags6 & 0x01) ? 'vertical' : 'horizontal'),
      sizeMatches: chrBytes === 0 ? bytes.length >= 16 + trainerBytes + prgBytes
        : bytes.length === expected,
      fileSize: bytes.length
    };
  }

  /* -------------------------------------------------------------------- init */

  /**
   * Initialise the wasm core once.
   * @param {{wasmBytes: Uint8Array, sen: object}} opts
   */
  function init(opts) {
    opts = opts || {};
    if (initialised) return true;

    var sen = opts.sen || (typeof self !== 'undefined' ? self.SEN : null) || root.SEN;
    if (!sen) throw new Error('SEN core is not loaded (js/vendor/sen.global.js missing?)');
    if (!opts.wasmBytes) throw new Error('SEN wasm bytes are required');

    wasmBytes = opts.wasmBytes;
    // The glue wants a BufferSource; a Node Buffer is fine, a Uint8Array is fine.
    sen.initSync({ module: wasmBytes });
    senModule = sen;
    initialised = true;
    return true;
  }

  function isReady() {
    return initialised && !!senModule;
  }

  /* ----------------------------------------------------------------- machine */

  /**
   * One emulated NES console.
   *
   * @param {object} opts
   *   romBytes   Uint8Array  the .nes file
   *   sampleRate number      audio sample rate (default 44100)
   *   onFrame    function(Uint8ClampedArray|Uint8Array rgba)  optional paint hook
   *   onAudio    function(Float32Array samples)               optional audio hook
   */
  function Machine(opts) {
    if (!isReady()) throw new Error('Core.init() must be called first');
    opts = opts || {};
    if (!opts.romBytes) throw new Error('romBytes are required');

    this.header = parseHeader(opts.romBytes);
    if (!this.header.valid) throw new Error('not a valid NES ROM: ' + this.header.error);

    this.sampleRate = opts.sampleRate || 44100;
    this.onFrame = opts.onFrame || null;
    this.onAudio = opts.onAudio || null;

    this._rom = new Uint8Array(opts.romBytes);
    this._emu = new senModule.Emulator(this._rom, this.sampleRate);
    this._pad1 = 0;
    this._pad2 = 0;
    this._audioEnergy = 0;
    this._audioPeak = 0;
    this._buffer = null;

    this.frameCount = 0;
    this.audioSamples = 0;
    this.crashed = false;
    this.crashMessage = '';
  }

  /** Raw RGBA frame from the core (a view into wasm memory — copy before keeping). */
  Machine.prototype.frameBuffer = function () {
    return this._emu.frameBuffer();
  };

  /** A stable copy of the current frame (RGBA, 245 760 bytes). */
  Machine.prototype.getBuffer = function () {
    var src = this._emu.frameBuffer();
    if (!this._buffer) this._buffer = new Uint8ClampedArray(FRAME_BYTES);
    this._buffer.set(src);
    return this._buffer;
  };

  /** Run exactly one video frame, drain audio, fire the hooks. */
  Machine.prototype.step = function () {
    if (this.crashed) return false;
    try {
      this._emu.setController1(this._pad1);
      this._emu.setController2(this._pad2);
      this._emu.runFrame();

      // takeAudio() empties the core's queue, so it is drained on every frame:
      // the samples go to the audio hook (when one is installed) and always
      // contribute to the energy meter.
      var audio = this._emu.takeAudio();
      if (audio && audio.length) {
        this.audioSamples += audio.length;
        for (var i = 0; i < audio.length; i++) {
          var v = audio[i];
          this._audioEnergy += v < 0 ? -v : v;
          if (v > this._audioPeak) this._audioPeak = v;
          else if (-v > this._audioPeak) this._audioPeak = -v;
        }
        if (this.onAudio) this.onAudio(audio);
      }

      this.frameCount++;
      if (this.onFrame) this.onFrame(this._emu.frameBuffer());
      return true;
    } catch (e) {
      this.crashed = true;
      this.crashMessage = (e && e.message) || String(e);
      return false;
    }
  };

  Machine.prototype.steps = function (n) {
    for (var i = 0; i < n; i++) {
      if (!this.step()) return i;
    }
    return n;
  };

  /* -------------------------------------------------------------------- pads */

  Machine.prototype.setController1 = function (mask) { this._pad1 = mask & 0xff; };
  Machine.prototype.setController2 = function (mask) { this._pad2 = mask & 0xff; };

  Machine.prototype.buttonDown = function (name) {
    var bit = BUTTONS[String(name).toUpperCase()];
    if (bit === undefined) throw new Error('unknown button: ' + name);
    this._pad1 |= bit;
    return this._pad1;
  };

  Machine.prototype.buttonUp = function (name) {
    var bit = BUTTONS[String(name).toUpperCase()];
    if (bit === undefined) throw new Error('unknown button: ' + name);
    this._pad1 &= ~bit;
    return this._pad1;
  };

  Machine.prototype.button = function (name) {
    return (this._pad1 & BUTTONS[String(name).toUpperCase()]) !== 0;
  };

  Machine.prototype.releaseAll = function () { this._pad1 = 0; this._pad2 = 0; };

  /* ------------------------------------------------------------------- state */

  Machine.prototype.saveState = function () {
    var s = this._emu.saveState();
    return s ? new Uint8Array(s) : null;
  };

  Machine.prototype.loadState = function (bytes) {
    if (!bytes) return false;
    this._emu.loadState(new Uint8Array(bytes));
    return true;
  };

  Machine.prototype.saveStateBase64 = function () {
    var bytes = this.saveState();
    if (!bytes) return null;
    return typeof Buffer !== 'undefined'
      ? Buffer.from(bytes).toString('base64')
      : bytesToBase64(bytes);
  };

  Machine.prototype.loadStateBase64 = function (b64) {
    if (!b64) return false;
    var bytes = typeof Buffer !== 'undefined'
      ? new Uint8Array(Buffer.from(b64, 'base64'))
      : base64ToBytes(b64);
    return this.loadState(bytes);
  };

  /** Power-cycle the console with the same cartridge (SEN needs the ROM again). */
  Machine.prototype.reset = function () {
    this._emu.reset(this._rom, this.sampleRate);
    this.frameCount = 0;
    this._pad1 = 0;
    this._pad2 = 0;
    this.audioSamples = 0;
    this._audioPeak = 0;
    return true;
  };

  /** Alias used by the UI. */
  Machine.prototype.hardReset = Machine.prototype.reset;

  /* ------------------------------------------------------------------ pixels */

  /** FNV-1a over the RGB channels of the current frame: stable frame identity. */
  Machine.prototype.frameHash = function () {
    var fb = this._emu.frameBuffer();
    var h = 0x811c9dc5;
    for (var i = 0; i < fb.length; i += 4) {
      h ^= fb[i];
      h = Math.imul(h, 16777619);
      h ^= fb[i + 1];
      h = Math.imul(h, 16777619);
      h ^= fb[i + 2];
      h = Math.imul(h, 16777619);
    }
    return h >>> 0;
  };

  /** Number of distinct colours on screen (a cheap "is this a real picture" test). */
  Machine.prototype.colorCount = function () {
    var fb = this._emu.frameBuffer();
    var seen = {};
    var n = 0;
    for (var i = 0; i < fb.length; i += 4) {
      var key = (fb[i] << 16) | (fb[i + 1] << 8) | fb[i + 2];
      if (!seen[key]) { seen[key] = 1; n++; }
    }
    return n;
  };

  Machine.prototype.isBlank = function () {
    return this.colorCount() <= 1;
  };

  /** Count of near-white pixels (used by the screen-transition heuristics). */
  Machine.prototype.whitePixelCount = function () {
    var fb = this._emu.frameBuffer();
    var n = 0;
    for (var i = 0; i < fb.length; i += 4) {
      if (fb[i] > 240 && fb[i + 1] > 240 && fb[i + 2] > 240) n++;
    }
    return n;
  };

  /**
   * 16x15 tile signature of the frame: a compact, robust fingerprint used to
   * tell screens apart (menus vs. gameplay) without depending on exact colours.
   */
  Machine.prototype.blockSignature = function () {
    var fb = this._emu.frameBuffer();
    var cols = 16, rows = 15;
    var bw = SCREEN_W / cols, bh = SCREEN_H / rows;
    var out = [];
    for (var by = 0; by < rows; by++) {
      for (var bx = 0; bx < cols; bx++) {
        var sum = 0, count = 0;
        for (var y = by * bh; y < (by + 1) * bh; y += 2) {
          for (var x = bx * bw; x < (bx + 1) * bw; x += 2) {
            var i = (y * SCREEN_W + x) * 4;
            sum += (fb[i] * 3 + fb[i + 1] * 5 + fb[i + 2] * 2) >> 3;
            count++;
          }
        }
        out.push(count ? Math.round(sum / count) : 0);
      }
    }
    return out;
  };

  /* ------------------------------------------------------------------- audio */

  /**
   * Total absolute audio energy produced since the previous call.
   * (The samples themselves are drained by step() every frame, so this is a
   * meter rather than a queue.)
   */
  Machine.prototype.takeAudioEnergy = function () {
    var energy = this._audioEnergy;
    this._audioEnergy = 0;
    return energy;
  };

  /** Peak amplitude seen so far (0..1). */
  Machine.prototype.audioPeak = function () { return this._audioPeak; };

  /* ------------------------------------------------------------------ helpers */

  function bytesToBase64(bytes) {
    var bin = '';
    for (var i = 0; i < bytes.length; i++) bin += String.fromCharCode(bytes[i]);
    return root.btoa ? root.btoa(bin) : null;
  }

  function base64ToBytes(b64) {
    var bin = root.atob ? root.atob(b64) : '';
    var out = new Uint8Array(bin.length);
    for (var i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i);
    return out;
  }

  return {
    BUTTONS: BUTTONS,
    BUTTON_NAMES: BUTTON_NAMES,
    SCREEN_W: SCREEN_W,
    SCREEN_H: SCREEN_H,
    FRAME_BYTES: FRAME_BYTES,
    parseHeader: parseHeader,
    init: init,
    isReady: isReady,
    Machine: Machine
  };
});

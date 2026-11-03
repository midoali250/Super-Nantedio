/**
 * Shared helpers for the bitvaultengine test-suite.
 *
 * The core is loaded into the *host* realm on purpose. (An earlier version used
 * `vm.createContext`, which hands the wasm glue a different realm's typed
 * arrays and silently broke audio and save-states.)
 */
'use strict';

const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const ROOT = path.resolve(__dirname, '..');
const WWW = path.join(ROOT, 'emulator', 'www');
const ROM_PATH = path.join(ROOT, 'roms', 'Super Mario Bros. + Duck Hunt (E) [!].nes');
const WASM_PATH = path.join(WWW, 'js', 'vendor', 'sen_bg.wasm');
const SEN_PATH = path.join(WWW, 'js', 'vendor', 'sen.global.js');
const CORE_PATH = path.join(WWW, 'js', 'nescore.js');

/* ------------------------------------------------------------------ loading */

let core = null;

/** Load sen.global.js into the host global scope, once. */
function loadSen() {
  if (global.SEN) return global.SEN;
  const src = fs.readFileSync(SEN_PATH, 'utf8');
  // sen.global.js is a classic script that assigns to `self.SEN`.
  const previous = global.self;
  global.self = global;
  try {
    new Function('self', src)(global);
  } finally {
    global.self = previous;
  }
  if (!global.SEN) throw new Error('sen.global.js did not define SEN');
  return global.SEN;
}

/** Load js/nescore.js as a CommonJS module (it uses UMD). */
function loadCore() {
  if (core) return core;
  const sen = loadSen();
  delete require.cache[require.resolve(CORE_PATH)];
  const mod = require(CORE_PATH);
  const wasm = fs.readFileSync(WASM_PATH);
  mod.init({ wasmBytes: new Uint8Array(wasm), sen });
  core = mod;
  return core;
}

function romBytes() {
  const b = fs.readFileSync(ROM_PATH);
  return new Uint8Array(b.buffer, b.byteOffset, b.length);
}

/** A fresh, booted Machine (no frames run yet). */
function newMachine(opts) {
  const Core = loadCore();
  return new Core.Machine(Object.assign({ romBytes: romBytes() }, opts || {}));
}

/**
 * Boot to the multicart screen and press START until the game is running.
 * Returns the machine; callers can keep stepping from there.
 */
function bootToTitle(machine) {
  const m = machine || newMachine();
  m.steps(100);
  tap(m, 'START');
  m.steps(60);
  return m;
}

/** Press a button for `frames` emulated frames, then release it. */
function tap(m, button, frames) {
  const hold = frames === undefined ? 4 : frames;
  m.buttonDown(button);
  m.steps(hold);
  m.buttonUp(button);
  m.steps(2);
  return m;
}

/**
 * Choose a cart from the multicart menu. 0 = Mario, 1 = Duck Hunt, 2 = Track Meet.
 * Presses SELECT from a fresh machine `index` times, then starts the game.
 */
function selectGame(machine, index) {
  const m = machine || newMachine();
  m.steps(100);
  tap(m, 'START');                      // leave the multicart logo
  for (let i = 0; i < index; i++) tap(m, 'SELECT', 4);
  m.steps(40);
  return m;
}

/* ------------------------------------------------------------------ screenshots */

/** Encode RGBA pixels as a PNG (no dependencies). */
function encodePng(width, height, rgba) {
  const stride = width * 4;
  const raw = Buffer.alloc((stride + 1) * height);
  for (let y = 0; y < height; y++) {
    raw[y * (stride + 1)] = 0;   // filter: none
    Buffer.from(rgba.buffer || rgba, rgba.byteOffset || 0, rgba.length)
      .copy(raw, y * (stride + 1) + 1, y * stride, (y + 1) * stride);
  }
  const chunks = [];
  const chunk = (type, data) => {
    const len = Buffer.alloc(4);
    len.writeUInt32BE(data.length);
    const body = Buffer.concat([Buffer.from(type, 'ascii'), data]);
    const crc = Buffer.alloc(4);
    crc.writeUInt32BE(crc32(body) >>> 0);
    return Buffer.concat([len, body, crc]);
  };
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(width, 0);
  ihdr.writeUInt32BE(height, 4);
  ihdr[8] = 8;    // bit depth
  ihdr[9] = 6;    // RGBA
  chunks.push(Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]));
  chunks.push(chunk('IHDR', ihdr));
  chunks.push(chunk('IDAT', zlib.deflateSync(raw, { level: 9 })));
  chunks.push(chunk('IEND', Buffer.alloc(0)));
  return Buffer.concat(chunks);
}

let crcTable = null;
function crc32(buf) {
  if (!crcTable) {
    crcTable = new Int32Array(256);
    for (let n = 0; n < 256; n++) {
      let c = n;
      for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
      crcTable[n] = c;
    }
  }
  let c = -1;
  for (let i = 0; i < buf.length; i++) c = crcTable[(c ^ buf[i]) & 0xff] ^ (c >>> 8);
  return c ^ -1;
}

/** Write the machine's current frame to a PNG file (creating folders). */
function writeScreenshot(machine, file) {
  const dir = path.dirname(path.resolve(file));
  fs.mkdirSync(dir, { recursive: true });
  const png = encodePng(256, 240, machine.getBuffer());
  fs.writeFileSync(path.resolve(file), png);
  return file;
}

/* ------------------------------------------------------------------ misc */

let freshBootHash = null;

/** Frame hash 120 frames after power-on (the reference for reset tests). */
function newMachineFreshBootHash() {
  if (freshBootHash === null) {
    const m = newMachine();
    m.steps(120);
    freshBootHash = m.frameHash();
  }
  return freshBootHash;
}

module.exports = {
  ROOT,
  WWW,
  ROM_PATH,
  WASM_PATH,
  SEN_PATH,
  CORE_PATH,
  loadSen,
  loadCore,
  romBytes,
  newMachine,
  bootToTitle,
  selectGame,
  tap,
  encodePng,
  writeScreenshot,
  newMachineFreshBootHash
};

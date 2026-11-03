/**
 * Golden-frame regression tests.
 *
 * The reference screenshots in tests/golden/ were produced by the shipped core
 * and reviewed by hand (mario-level-start.png is World 1-1, duckhunt-round.png
 * is Duck Hunt round 1). If a core upgrade ever changes what the player sees,
 * these tests fail and point at the exact frame.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const h = require('../helpers');

/** Minimal PNG reader for the 8-bit RGBA files we write ourselves. */
function decodePng(buf) {
  let i = 8;
  let width = 0, height = 0, colorType = 0, bitDepth = 0;
  const idat = [];
  while (i < buf.length) {
    const len = buf.readUInt32BE(i);
    const type = buf.toString('ascii', i + 4, i + 8);
    const data = buf.subarray(i + 8, i + 8 + len);
    if (type === 'IHDR') {
      width = data.readUInt32BE(0);
      height = data.readUInt32BE(4);
      bitDepth = data[8];
      colorType = data[9];
    } else if (type === 'IDAT') {
      idat.push(data);
    } else if (type === 'IEND') {
      break;
    }
    i += 12 + len;
  }
  if (bitDepth !== 8 || colorType !== 6) throw new Error('unexpected PNG format');
  const raw = zlib.inflateSync(Buffer.concat(idat));
  const out = Buffer.alloc(width * height * 4);
  const stride = width * 4;
  for (let y = 0; y < height; y++) {
    raw.copy(out, y * stride, y * (stride + 1) + 1, (y + 1) * (stride + 1));
  }
  return { width, height, rgba: out };
}

function golden(name) {
  return decodePng(fs.readFileSync(path.join(__dirname, '..', 'golden', name)));
}

function diffRatio(a, b) {
  let diff = 0;
  for (let i = 0; i < a.length; i += 4) {
    if (a[i] !== b[i] || a[i + 1] !== b[i + 1] || a[i + 2] !== b[i + 2]) diff++;
  }
  return diff / (a.length / 4);
}

function playMarioToLevel(m) {
  for (let f = 0; f < 420; f++) {
    if (f === 100) m.buttonDown('START');
    if (f === 130) m.buttonUp('START');
    if (f === 180) m.buttonDown('START');
    if (f === 210) m.buttonUp('START');
    m.step();
  }
  return m;
}

function playDuckHuntRound(m) {
  for (let f = 0; f < 480; f++) {
    if (f === 100) m.buttonDown('SELECT');
    if (f === 118) m.buttonUp('SELECT');
    if (f === 200) m.buttonDown('START');
    if (f === 220) m.buttonUp('START');
    if (f === 320) m.buttonDown('START');
    if (f === 340) m.buttonUp('START');
    m.step();
  }
  return m;
}

module.exports = {
  name: 'Golden frames (visual regression)',
  tests: {
    'Super Mario Bros. World 1-1 start frame matches the reference': (t) => {
      const ref = golden('mario-level-start.png');
      const m = playMarioToLevel(h.newMachine());
      const ratio = diffRatio(m.getBuffer(), ref.rgba);
      t.greater(-ratio, -0.005, 'frame differs from the golden reference (' + (ratio * 100).toFixed(2) + '% of pixels)');
      t.equal(m.frameHash(), 1842925694, 'frame hash changed — the emulator output is not what shipped');
    },

    'Mario walking + jumping frame matches the reference': (t) => {
      const ref = golden('mario-walk-jump.png');
      const m = playMarioToLevel(h.newMachine());
      m.buttonDown('RIGHT');
      m.steps(80);
      m.buttonUp('RIGHT');
      m.buttonDown('A');
      m.steps(10);
      const ratio = diffRatio(m.getBuffer(), ref.rgba);
      t.greater(-ratio, -0.005, 'walk/jump frame differs (' + (ratio * 100).toFixed(2) + '%)');
      t.equal(m.frameHash(), 1758842379);
    },

    'Duck Hunt round 1 frame matches the reference': (t) => {
      const ref = golden('duckhunt-round.png');
      const m = playDuckHuntRound(h.newMachine());
      const ratio = diffRatio(m.getBuffer(), ref.rgba);
      t.greater(-ratio, -0.005, 'Duck Hunt frame differs (' + (ratio * 100).toFixed(2) + '%)');
      t.equal(m.frameHash(), 4051551369);
    },

    'golden screenshots are the expected size': (t) => {
      for (const name of ['mario-level-start.png', 'mario-walk-jump.png', 'duckhunt-round.png']) {
        const png = golden(name);
        t.equal(png.width, 256, name + ' width');
        t.equal(png.height, 240, name + ' height');
      }
    },

    'reference frames are not blank (guards against bogus goldens)': (t) => {
      for (const name of ['mario-level-start.png', 'mario-walk-jump.png', 'duckhunt-round.png']) {
        const png = golden(name);
        const colors = new Set();
        for (let i = 0; i < png.rgba.length; i += 4) {
          colors.add((png.rgba[i] << 16) | (png.rgba[i + 1] << 8) | png.rgba[i + 2]);
        }
        t.greater(colors.size, 3, name + ' should contain a real picture');
      }
    }
  }
};

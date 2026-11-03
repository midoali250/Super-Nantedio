/**
 * Gameplay tests — the part that proves the *game* works, not just the code.
 *
 * Everything here is driven through the same public API the phone's buttons use
 * (buttonDown/buttonUp + step) and verified against the real pixels.
 *
 * Multicart menu order (verified by rendering the cart):
 *   0 = Super Mario Bros.   1 = Duck Hunt   2 = World Class Track Meet
 */
'use strict';

const h = require('../helpers');

/** Run a frame-scripted timeline: [{f, down:[..], up:[..]}, ...] */
function play(machine, timeline, lastFrame) {
  const byFrame = {};
  for (const ev of timeline) (byFrame[ev.f] = byFrame[ev.f] || []).push(ev);
  for (let f = 0; f <= lastFrame; f++) {
    const evs = byFrame[f];
    if (evs) {
      for (const ev of evs) {
        for (const b of ev.down || []) machine.buttonDown(b);
        for (const b of ev.up || []) machine.buttonUp(b);
      }
    }
    machine.step();
  }
  return machine;
}

/** Boot the multicart and start Super Mario Bros. (menu entry 0). */
function startMario(m) {
  return play(m, [
    { f: 100, down: ['START'] }, { f: 130, up: ['START'] },   // dismiss the multicart logo
    { f: 180, down: ['START'] }, { f: 210, up: ['START'] }    // pick 1 PLAYER GAME
  ], 420);
}

/** Boot the multicart and start Duck Hunt (menu entry 1). */
function startDuckHunt(m) {
  return play(m, [
    { f: 100, down: ['SELECT'] }, { f: 118, up: ['SELECT'] },  // switch cart to Duck Hunt
    { f: 200, down: ['START'] }, { f: 220, up: ['START'] },
    { f: 320, down: ['START'] }, { f: 340, up: ['START'] }
  ], 480);
}

/** Horizontal centre of Mario's red cap/shirt, or -1 when he is not visible. */
function marioX(m) {
  const fb = m.getBuffer();
  const xs = [];
  for (let y = 165; y < 225; y++) {
    for (let x = 0; x < 256; x++) {
      const i = (y * 256 + x) * 4;
      const r = fb[i], g = fb[i + 1], b = fb[i + 2];
      if (r > 150 && g < 110 && b < 110) xs.push(x);
    }
  }
  if (!xs.length) return -1;
  xs.sort((a, b) => a - b);
  return xs[Math.floor(xs.length / 2)];
}

/** Highest row containing Mario's colours (smaller y = higher on screen). */
function marioTop(m) {
  const fb = m.getBuffer();
  for (let y = 120; y < 235; y++) {
    for (let x = 0; x < 256; x++) {
      const i = (y * 256 + x) * 4;
      if (fb[i] > 150 && fb[i + 1] < 110 && fb[i + 2] < 110) return y;
    }
  }
  return -1;
}

module.exports = {
  name: 'Gameplay (Super Mario Bros. + Duck Hunt)',
  tests: {
    'multicart menu renders a real screen': (t) => {
      const m = h.newMachine();
      m.steps(120);
      t.greater(m.colorCount(), 2);
      t.equal(m.isBlank(), false);
      t.greater(m.frameHash(), 0);
    },

    'START on the multicart boots Super Mario Bros. World 1-1': (t) => {
      const m = startMario(h.newMachine());
      const px = m.getBuffer();
      t.greater(m.colorCount(), 6, 'the level uses more colours than the menus');
      // SEN renders World 1-1's sky as a strong blue.
      let sky = 0;
      for (let i = 0; i < px.length; i += 4) {
        if (px[i + 2] > 200 && px[i] < 160 && px[i + 1] < 170) sky++;
      }
      t.greater(sky, 10000, 'World 1-1 must show its blue sky');
    },

    'Mario is drawn on screen': (t) => {
      const m = startMario(h.newMachine());
      const x = marioX(m);
      t.greater(x, -1, 'Mario (red pixels) should be visible after the level starts');
    },

    'RIGHT makes Mario walk to the right': (t) => {
      const m = startMario(h.newMachine());
      const before = marioX(m);
      m.buttonDown('RIGHT');
      m.steps(90);
      m.buttonUp('RIGHT');
      m.steps(5);
      const after = marioX(m);
      t.greater(after - before, 25, 'holding RIGHT must move Mario right (' + before + ' -> ' + after + ')');
    },

    'LEFT moves Mario back again': (t) => {
      const m = startMario(h.newMachine());
      m.buttonDown('RIGHT');
      m.steps(100);
      m.buttonUp('RIGHT');
      m.steps(5);
      const right = marioX(m);
      m.buttonDown('LEFT');
      m.steps(50);
      m.buttonUp('LEFT');
      m.steps(5);
      const left = marioX(m);
      t.ok(left < right, 'holding LEFT must move Mario left (' + right + ' -> ' + left + ')');
    },

    'A makes Mario jump (his sprite moves up)': (t) => {
      const m = startMario(h.newMachine());
      const ground = marioTop(m);
      m.buttonDown('A');
      m.steps(14);
      const air = marioTop(m);
      m.buttonUp('A');
      t.ok(air < ground, 'Mario must rise while A is held (y ' + ground + ' -> ' + air + ')');
      t.greater(ground - air, 8, 'a jump lifts Mario several pixels');
    },

    'the game loop keeps running without input': (t) => {
      const m = startMario(h.newMachine());
      const a = m.frameHash();
      m.steps(90);
      t.notEqual(a, m.frameHash(), 'frame must change without input (timer, enemies)');
    },

    'the game survives 60 seconds of play without crashing': (t) => {
      const m = startMario(h.newMachine());
      m.buttonDown('RIGHT');
      for (let i = 0; i < 3600; i++) {
        if (i % 40 === 0) m.buttonDown('A');
        else if (i % 40 === 12) m.buttonUp('A');
        if (!m.step()) break;
      }
      m.releaseAll();
      t.equal(m.crashed, false, 'no invalid opcode / crash: ' + (m.crashMessage || ''));
      t.greater(m.frameCount, 4000, 'the emulator kept running for the whole minute');
      t.equal(m.isBlank(), false, 'still rendering after a minute of play');
    },

    'second game (Duck Hunt) boots from the same cart': (t) => {
      const m = startDuckHunt(h.newMachine());
      t.equal(m.crashed, false);
      t.greater(m.colorCount(), 2, 'Duck Hunt draws a real screen');
      const sig = m.blockSignature().join(',');
      const mario = startMario(h.newMachine()).blockSignature().join(',');
      t.notEqual(sig, mario, 'Duck Hunt must not render the Mario level');
    },

    'Duck Hunt keeps running when the light gun is triggered': (t) => {
      const m = startDuckHunt(h.newMachine());
      // Controller 2 is the light-gun port. SEN has no Zapper, so we only prove
      // that the ROM keeps running instead of dying when port 2 is pulsed.
      m.setController2(0x01);
      m.steps(6);
      m.setController2(0);
      m.steps(60);
      t.equal(m.crashed, false, 'shooting must not crash the emulator');
      t.equal(m.isBlank(), false, 'screen keeps updating after a shot');
    },

    'reset from gameplay returns to power-on': (t) => {
      const m = startMario(h.newMachine());
      m.reset();
      m.steps(120);
      t.equal(m.frameHash(), h.newMachineFreshBootHash());
    }
  }
};

/**
 * Emulator core tests — the SEN wasm wrapper in js/nescore.js.
 * Everything here runs headless in Node, no DOM involved.
 */
'use strict';

const h = require('../helpers');

module.exports = {
  name: 'Emulator core (SEN/WASM)',
  tests: {
    'WASM core initialises once and reports ready': (t) => {
      const Core = h.loadCore();
      t.equal(Core.isReady(), true);
      t.equal(typeof Core.Machine, 'function');
      t.equal(Core.SCREEN_W, 256);
      t.equal(Core.SCREEN_H, 240);
    },

    'rejects a file that is not a NES ROM': (t) => {
      const Core = h.loadCore();
      let threw = false;
      try {
        new Core.Machine({ romBytes: new Uint8Array(64) });
      } catch (e) {
        threw = true;
      }
      t.ok(threw, 'booting a junk file must throw');
    },

    'boots the multicart and renders a real picture': (t) => {
      const m = h.newMachine();
      const before = m.frameHash();
      m.steps(120);
      t.equal(m.crashed, false, 'no crash: ' + m.crashMessage);
      t.equal(m.frameCount, 120);
      t.notEqual(m.frameHash(), before, 'the screen must change from the first frame');
      t.greater(m.colorCount(), 2, 'a real NES picture, not a blank screen');
      t.equal(m.isBlank(), false);
      t.greater(m.getBuffer().length, 245000, 'RGBA frame is 256x240x4');
      t.equal(m.getBuffer().length, 245760);
    },

    'animation runs during power-on (frame content changes)': (t) => {
      const m = h.newMachine();
      m.steps(30);
      const a = m.frameHash();
      m.steps(30);
      t.notEqual(a, m.frameHash(), 'the boot screen animates, so frames must differ');
    },

    'emulation is deterministic for identical input': (t) => {
      const run = () => {
        const m = h.newMachine();
        m.steps(120);
        m.buttonDown('START');
        m.steps(10);
        m.buttonUp('START');
        m.steps(60);
        return m.frameHash();
      };
      t.equal(run(), run());
    },

    'button()/buttonDown()/buttonUp() keep a consistent mask': (t) => {
      const m = h.newMachine();
      t.equal(m.button('A'), false);
      m.buttonDown('A');
      t.equal(m.button('A'), true);
      m.buttonDown('B');
      m.buttonDown('RIGHT');
      t.equal(m.button('A') && m.button('B') && m.button('RIGHT'), true);
      t.equal(m.button('LEFT'), false);
      m.buttonUp('A');
      t.equal(m.button('A'), false);
      t.equal(m.button('B'), true, 'releasing one button keeps the others held');
      m.releaseAll();
      t.equal(m.button('B'), false);
      t.throws(() => m.buttonDown('JUMP'));
    },

    'controller mask values match the NES bit order': (t) => {
      const Core = h.loadCore();
      t.equal(Core.BUTTONS.A, 0x01);
      t.equal(Core.BUTTONS.B, 0x02);
      t.equal(Core.BUTTONS.SELECT, 0x04);
      t.equal(Core.BUTTONS.START, 0x08);
      t.equal(Core.BUTTONS.UP, 0x10);
      t.equal(Core.BUTTONS.DOWN, 0x20);
      t.equal(Core.BUTTONS.LEFT, 0x40);
      t.equal(Core.BUTTONS.RIGHT, 0x80);
      const m = h.newMachine();
      m.buttonDown('RIGHT');
      m.buttonDown('A');
      t.equal(m._pad1, 0x81);
    },

    'pressing START really reaches the game (screen changes)': (t) => {
      const m = h.newMachine();
      m.steps(150);
      const before = m.frameHash();
      h.tap(m, 'START', 8);
      m.steps(60);
      t.notEqual(m.frameHash(), before, 'START must move the multicart menu');
      t.equal(m.crashed, false);
    },

    'save state / load state round-trips losslessly': (t) => {
      const m = h.newMachine();
      m.steps(150);
      h.tap(m, 'START');          // now on the Mario "1 PLAYER / 2 PLAYER" menu
      m.steps(40);
      const state = m.saveState();
      t.ok(state && state.length > 1000, 'state should not be empty');
      t.equal(state.length, 32768, 'SEN state image size');

      h.tap(m, 'START');          // start the level so the screen definitely moves
      m.steps(90);
      const drifted = m.frameHash();

      m.loadState(state);
      m.steps(1);
      const restored = m.frameHash();

      const ctl = h.newMachine();
      ctl.steps(150);
      h.tap(ctl, 'START');
      ctl.steps(40);
      ctl.steps(1);
      t.equal(restored, ctl.frameHash(), 'restoring the exact same state must reproduce the same frame');
      t.notEqual(restored, drifted, 'the state must actually roll the game back');
    },

    'base64 state helpers survive a round-trip': (t) => {
      const m = h.newMachine();
      m.steps(140);
      const b64 = m.saveStateBase64();
      t.ok(b64 && b64.length > 1000, 'base64 state');
      const clone = h.newMachine();
      t.equal(clone.loadStateBase64(b64), true);
      clone.steps(1);
      m.steps(1);
      t.equal(clone.frameHash(), m.frameHash());
      t.equal(clone.loadStateBase64(null), false);
    },

    'hardware reset returns to the power-on screen': (t) => {
      const m = h.newMachine();
      m.steps(150);
      h.tap(m, 'START');
      m.steps(120);
      m.reset();
      t.equal(m.frameCount, 0, 'frame counter restarts');
      m.steps(120);
      t.equal(m.frameHash(), h.newMachineFreshBootHash());
    },

    'audio pipeline drains ~44.1 kHz samples every frame': (t) => {
      const m = h.newMachine();
      m.steps(60);
      t.greater(m.audioSamples, 0, 'samples must be collected');
      const perFrame = m.audioSamples / 60;
      t.close(perFrame, 44100 / 60, 12, 'one video frame should yield ~735 audio samples');
    },

    'takeAudioEnergy() reports real signal and is drained': (t) => {
      const m = h.newMachine();
      m.steps(220);
      h.tap(m, 'START');
      m.steps(30);
      h.tap(m, 'START');
      m.steps(220);                                 // World 1-1 music is playing now
      const energy = m.takeAudioEnergy();
      t.greater(m.audioPeak(), 0.02, 'the APU must actually make sound: peak ' + m.audioPeak());
      t.greater(energy, 100, 'the music must carry real energy');
      t.equal(m.takeAudioEnergy(), 0, 'reading the meter must reset it');
      m.steps(30);
      t.greater(m.takeAudioEnergy(), 0, 'and it accumulates again');
    },

    'onFrame/onAudio hooks fire once per frame': (t) => {
      let frames = 0;
      let samples = 0;
      const m = h.newMachine({
        onFrame: () => { frames++; },
        onAudio: (a) => { samples += a.length; }
      });
      m.steps(30);
      t.equal(frames, 30);
      t.greater(samples, 0);
      t.equal(samples, m.audioSamples);
    },

    'blockSignature and whitePixelCount describe the frame': (t) => {
      const m = h.newMachine();
      m.steps(120);
      const sig = m.blockSignature();
      t.equal(sig.length, 16 * 15);
      t.greater(sig.reduce((a, b) => a + b, 0), 0);
      t.greater(m.whitePixelCount(), 0, 'the multicart logo has white pixels');
    }
  }
};

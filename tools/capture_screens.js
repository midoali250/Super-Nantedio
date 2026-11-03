#!/usr/bin/env node
/**
 * Render the emulator screens into docs/screenshots/*.png using the same core
 * and the same scripted input the test-suite uses. Run by CI and by hand:
 *
 *     node tools/capture_screens.js
 *
 * These images are what the README shows, so they are always genuine output of
 * the shipped build — never mock ups.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const h = require('../tests/helpers');

const OUT = path.join(h.ROOT, 'docs', 'screenshots');

function shot(machine, name) {
  const file = path.join(OUT, name + '.png');
  h.writeScreenshot(machine, file);
  const kb = (fs.statSync(file).size / 1024).toFixed(1);
  console.log('  ' + name + '.png  (' + kb + ' kB, hash ' + machine.frameHash() + ')');
  return file;
}

function runTimeline(machine, events, lastFrame) {
  const byFrame = {};
  for (const ev of events) (byFrame[ev.f] = byFrame[ev.f] || []).push(ev);
  for (let f = 0; f <= lastFrame; f++) {
    for (const ev of byFrame[f] || []) {
      for (const b of ev.down || []) machine.buttonDown(b);
      for (const b of ev.up || []) machine.buttonUp(b);
    }
    machine.step();
  }
  return machine;
}

function main() {
  fs.mkdirSync(OUT, { recursive: true });
  console.log('rendering ' + path.relative(h.ROOT, OUT) + '/');

  // 1. the multicart boot screen
  const boot = h.newMachine();
  boot.steps(120);
  shot(boot, '01-multicart');

  // 2. the Mario "1 PLAYER / 2 PLAYER" screen
  const menu = runTimeline(h.newMachine(), [
    { f: 100, down: ['START'] }, { f: 130, up: ['START'] }
  ], 260);
  shot(menu, '02-mario-menu');

  // 3. World 1-1 right after the level starts
  const level = runTimeline(h.newMachine(), [
    { f: 100, down: ['START'] }, { f: 130, up: ['START'] },
    { f: 180, down: ['START'] }, { f: 210, up: ['START'] }
  ], 420);
  shot(level, '03-world-1-1');

  // 4. Mario running and jumping
  level.buttonDown('RIGHT');
  level.steps(80);
  level.buttonUp('RIGHT');
  level.buttonDown('A');
  level.steps(10);
  level.buttonUp('A');
  shot(level, '04-mario-jump');

  // 5. Duck Hunt, round 1
  const duck = runTimeline(h.newMachine(), [
    { f: 100, down: ['SELECT'] }, { f: 118, up: ['SELECT'] },
    { f: 200, down: ['START'] }, { f: 220, up: ['START'] },
    { f: 320, down: ['START'] }, { f: 340, up: ['START'] }
  ], 480);
  shot(duck, '05-duck-hunt');

  // 6. World Class Track Meet (third cart on the multicart)
  const track = runTimeline(h.newMachine(), [
    { f: 100, down: ['SELECT'] }, { f: 118, up: ['SELECT'] },
    { f: 140, down: ['SELECT'] }, { f: 158, up: ['SELECT'] },
    { f: 240, down: ['START'] }, { f: 260, up: ['START'] }
  ], 560);
  shot(track, '06-track-meet');

  console.log('done: ' + fs.readdirSync(OUT).length + ' screenshots');
}

main();

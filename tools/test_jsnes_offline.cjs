#!/usr/bin/env node
// Exercise the bundled browser script with the actual embedded ROM, offline.
const assert = require('assert');
const fs = require('fs');
const vm = require('vm');
const path = require('path');
const root = path.resolve(__dirname, '..');
const assets = path.join(root, 'android/app/src/main/assets');
const html = fs.readFileSync(path.join(assets, 'emulator.html'), 'utf8');
assert(html.includes('vendor/jsnes/jsnes.min.js'));
assert(!html.includes('cdn.jsdelivr.net/npm/jsnes'));
const jsnes = require(path.join(assets, 'vendor/jsnes/jsnes.min.js'));
const rom = fs.readFileSync(path.join(assets, 'mario.nes'));
let paints = 0, lastPixels;
const context2d = {
  createImageData: (w, h) => ({data: new Uint8ClampedArray(w * h * 4)}),
  putImageData: data => { paints++; lastPixels = data.data; }
};
const elements = {};
function element(id) {
  return elements[id] || (elements[id] = {style:{}, events:{},
    addEventListener(n, fn) { this.events[n] = fn; },
    getBoundingClientRect(){ return {left:0, top:0, right:160, bottom:160}; },
    getContext(){ return context2d; }});
}
const handlers = {};
let raf = null;
const sandbox = {
  jsnes, console, Uint8Array, Uint8ClampedArray,
  NES:{getROMBase64: () => rom.toString('base64')},
  atob: s => Buffer.from(s, 'base64').toString('binary'),
  document:{getElementById: element},
  setTimeout: fn => fn(),
  requestAnimationFrame: fn => { raf=fn; return 1; },
  cancelAnimationFrame: () => { raf=null; },
};
sandbox.window = sandbox;
sandbox.window.addEventListener = (name, fn) => { handlers[name] = fn; };
vm.createContext(sandbox);
const scripts = [...html.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/g)];
assert(scripts.length >= 2);
vm.runInContext(scripts[scripts.length - 1][1], sandbox);
handlers.DOMContentLoaded();
assert(sandbox.nes && sandbox.playing && raf, 'ROM boot and frame loop');
for (let i=1; i<=180; i++) { const callback=raf; assert(callback); callback(i*17); }
assert(paints > 100, `frames painted: ${paints}`);
assert(lastPixels.some((v,i) => i%4!==3 && v!==0), 'rendered pixels');
let event = {key:'z', preventDefault(){}};
handlers.keydown(event);
assert.strictEqual(sandbox.nes.controllers[1].state[jsnes.Controller.BUTTON_A], 0x41, 'button A pressed');
handlers.keyup(event);
assert.strictEqual(sandbox.nes.controllers[1].state[jsnes.Controller.BUTTON_A], 0x40, 'button A released');
sandbox.nesPause(); assert(!sandbox.playing && !raf, 'pause');
sandbox.nesPlay(); assert(sandbox.playing && raf, 'resume');
sandbox.nesReset(); assert(sandbox.playing && raf, 'reset and reload');
console.log('PASS: local jsnes, embedded ROM, frame output, A input, pause/resume/reset');

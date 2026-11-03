/**
 * Boot emulator/www/index.html inside jsdom.
 *
 * Shared by:
 *   • tests/suites/06-webapp.test.js   (the UI test-suite, wwwRoot = emulator/www)
 *   • tools/verify_apk.js              (the same boot, but from the *extracted APK*)
 *
 * jsdom has no WebAudio or canvas renderer, so `beforeParse` supplies the small
 * slice of the canvas API the app uses and the app falls back to 44.1 kHz —
 * which is also the fallback path on devices without an AudioContext.
 */
'use strict';

const fs = require('fs');
const path = require('path');

const ORIGIN = 'https://appassets.androidplatform.net/assets/';
const ROM_NAME = 'Super Mario Bros. + Duck Hunt (E) [!].nes';
const ROM_URL = 'games/Super%20Mario%20Bros.%20%2B%20Duck%20Hunt%20(E)%20%5B!%5D.nes';

let jsdomModule;
let jsdomError = null;

function requireJsdom() {
  if (jsdomModule) return jsdomModule;
  try {
    jsdomModule = require('jsdom');
    return jsdomModule;
  } catch (e) {
    jsdomError = e;   // kept so the runner can print the real reason
    return null;
  }
}

function jsdomUnavailableReason() {
  requireJsdom();
  return jsdomError ? String(jsdomError.message || jsdomError) : null;
}

/**
 * @param {string} wwwRoot  the folder that holds index.html (and js/, css/, games/)
 * @returns {object} the JSDOM instance
 */
function bootPage(wwwRoot) {
  const jsdomLib = requireJsdom();
  if (!jsdomLib) throw new Error('jsdom is not installed (npm install)');

  const html = fs.readFileSync(path.join(wwwRoot, 'index.html'), 'utf8');

  // serve <script src> / <link href> from wwwRoot instead of the network
  const resources = {
    interceptors: [
      jsdomLib.requestInterceptor((request) => {
        const rel = decodeURIComponent(String(request.url).replace(ORIGIN, '').split('?')[0]);
        const full = path.join(wwwRoot, rel);
        if (!fs.existsSync(full)) {
          return Promise.resolve(new Response('not found', { status: 404 }));
        }
        const body = fs.readFileSync(full);
        const type = /\.m?js$/.test(rel) ? 'application/javascript'
          : /\.css$/.test(rel) ? 'text/css'
            : /\.wasm$/.test(rel) ? 'application/wasm'
              : /\.html$/.test(rel) ? 'text/html; charset=utf-8'
                : 'application/octet-stream';
        return Promise.resolve(new Response(body, {
          status: 200,
          headers: { 'content-type': type }
        }));
      })
    ]
  };

  return new jsdomLib.JSDOM(html, {
    url: ORIGIN + 'index.html',
    runScripts: 'dangerously',
    resources,
    pretendToBeVisual: true,
    beforeParse(window) {
      // asset fetch, exactly as the Android WebView serves them
      window.fetch = function (url) {
        let file = decodeURIComponent(String(url).replace(ORIGIN, '').split('?')[0]);
        if (String(url).indexOf(ROM_URL) !== -1 || /\.nes$/i.test(file)) {
          file = 'games/' + ROM_NAME;
        }
        const full = path.join(wwwRoot, file);
        if (!fs.existsSync(full)) return Promise.resolve({ ok: false, status: 404 });
        const bytes = fs.readFileSync(full);
        return Promise.resolve({
          ok: true,
          status: 200,
          arrayBuffer: () => Promise.resolve(
            bytes.buffer.slice(bytes.byteOffset, bytes.byteOffset + bytes.length))
        });
      };

      // deterministic requestAnimationFrame driven by the caller
      window.__rafQueue = [];
      window.requestAnimationFrame = function (cb) {
        window.__rafQueue.push(cb);
        return window.__rafQueue.length;
      };
      window.cancelAnimationFrame = function () { };

      // jsdom has no canvas: implement the tiny slice app.js uses
      const ctx = {
        createImageData: (w, h) => ({ width: w, height: h, data: new Uint8ClampedArray(w * h * 4) }),
        putImageData: function (image) { this.__last = image; },
        getImageData: function (x, y, w, h) {
          const src = this.__last ? this.__last.data : new Uint8ClampedArray(w * h * 4);
          return { width: w, height: h, data: new Uint8ClampedArray(src) };
        },
        drawImage: function () { },
        fillRect: function () { },
        clearRect: function () { },
        save: function () { },
        restore: function () { },
        setTransform: function () { },
        scale: function () { },
        imageSmoothingEnabled: false
      };
      window.HTMLCanvasElement.prototype.getContext = function () { return ctx; };
      window.HTMLCanvasElement.prototype.toDataURL = function () {
        return 'data:image/png;base64,iVBORw0KGgo=';
      };
      window.matchMedia = window.matchMedia || (() => ({
        matches: false, addListener() { }, removeListener() { },
        addEventListener() { }, removeEventListener() { }
      }));
    }
  });
}

/** Run `frames` animation frames with a constant 16.67 ms clock. */
function pump(window, frames) {
  for (let i = 0; i < frames; i++) {
    const queue = window.__rafQueue;
    window.__rafQueue = [];
    if (!queue.length) return i;
    const ts = 1000 + i * (1000 / 60);
    for (const cb of queue) cb(ts);
  }
  return frames;
}

/** Poll until app.js finished its async boot (fetch -> Core.init -> play). */
function waitBooted(window, tries) {
  let left = tries === undefined ? 300 : tries;
  return new Promise((resolve) => {
    const check = () => {
      const app = window.SNESApp;
      if (app && app.snapshot().booted) return resolve(true);
      if (left-- <= 0) return resolve(false);
      setTimeout(check, 10);
    };
    check();
  });
}

/** Pad buttons: id="btn-a" or data-btn="UP" (the d-pad has no ids). */
function padEl(window, name) {
  const clean = String(name).replace(/^btn-/, '');
  return window.document.getElementById('btn-' + clean.toLowerCase())
    || window.document.querySelector('[data-btn="' + clean.toUpperCase() + '"]');
}

function hold(window, name, pointerId) {
  const el = padEl(window, name);
  if (!el) throw new Error('missing pad button ' + name);
  const ev = new window.Event('pointerdown', { bubbles: true, cancelable: true });
  ev.pointerId = pointerId || 1;
  el.dispatchEvent(ev);
  return el;
}

function release(window, name, pointerId) {
  const el = padEl(window, name);
  if (!el) return;
  const ev = new window.Event('pointerup', { bubbles: true, cancelable: true });
  ev.pointerId = pointerId || 1;
  el.dispatchEvent(ev);
}

function press(window, name, frames) {
  hold(window, name);
  pump(window, frames || 4);
  release(window, name);
  pump(window, 2);
}

function click(window, id) {
  const el = window.document.getElementById(id);
  if (!el) throw new Error('missing #' + id);
  el.dispatchEvent(new window.Event('click', { bubbles: true }));
}

/** Start World 1-1 through the on-screen pad. */
function startMario(window) {
  pump(window, 100);
  press(window, 'start', 8);
  pump(window, 60);
  press(window, 'start', 8);
  pump(window, 240);
}

/** Count the World 1-1 sky pixels currently on the canvas. */
function skyPixels(window) {
  const px = window.document.getElementById('canvas').getContext('2d')
    .getImageData(0, 0, 256, 240).data;
  let sky = 0;
  for (let i = 0; i < px.length; i += 4) {
    if (px[i + 2] > 200 && px[i] < 160 && px[i + 1] < 170) sky++;
  }
  return sky;
}

module.exports = {
  ORIGIN,
  ROM_NAME,
  ROM_URL,
  requireJsdom,
  jsdomUnavailableReason,
  bootPage,
  pump,
  waitBooted,
  padEl,
  hold,
  release,
  press,
  click,
  startMario,
  skyPixels
};

/**
 * The real UI in a real DOM.
 *
 * The other suites exercise the core directly. This one boots index.html inside
 * jsdom — the same HTML the phone loads — lets app.js pull the wasm core and the
 * ROM through the same fetch() path it uses on Android, then plays the game by
 * dispatching DOM events on the on-screen pad and checks the canvas.
 *
 * jsdom has no WebAudio, so the app falls back to 44.1 kHz; that is exactly the
 * fallback path used on devices without an AudioContext.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const h = require('../helpers');

const WWW = path.join(h.ROOT, 'emulator', 'www');
const ORIGIN = 'https://appassets.androidplatform.net/assets/';
const ROM_URL = 'games/Super%20Mario%20Bros.%20%2B%20Duck%20Hunt%20(E)%20%5B!%5D.nes';
const WASM_URL = 'js/vendor/sen_bg.wasm';

let jsdom = null;
try {
  jsdom = require('jsdom');
} catch (e) {
  jsdom = null;
}

/**
 * jsdom 30 resource loader: serve <script src>/<link href> from emulator/www
 * instead of the network, and keep the asset-origin URL the app expects.
 */
function localResources() {
  return {
    interceptors: [
      jsdom.requestInterceptor((request) => {
        const rel = decodeURIComponent(String(request.url).replace(ORIGIN, '').split('?')[0]);
        const full = path.join(WWW, rel);
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
}

function bootPage() {
  const html = fs.readFileSync(path.join(WWW, 'index.html'), 'utf8');
  const dom = new jsdom.JSDOM(html, {
    url: ORIGIN + 'index.html',
    runScripts: 'dangerously',
    resources: localResources(),
    pretendToBeVisual: true,
    beforeParse(window) {
      // asset fetch, exactly like the Android WebView serves them
      window.fetch = function (url) {
        let file = decodeURIComponent(String(url).replace(ORIGIN, '').split('?')[0]);
        if (String(url).indexOf(ROM_URL) !== -1 || /\.nes$/i.test(file)) {
          file = file.replace(/^games\/.*$/, 'games/Super Mario Bros. + Duck Hunt (E) [!].nes');
        }
        const full = path.join(WWW, file);
        if (!fs.existsSync(full)) return Promise.resolve({ ok: false, status: 404 });
        const bytes = fs.readFileSync(full);
        return Promise.resolve({
          ok: true,
          status: 200,
          arrayBuffer: () => Promise.resolve(
            bytes.buffer.slice(bytes.byteOffset, bytes.byteOffset + bytes.length))
        });
      };

      // deterministic requestAnimationFrame driven by the test
      window.__rafQueue = [];
      window.requestAnimationFrame = function (cb) {
        window.__rafQueue.push(cb);
        return window.__rafQueue.length;
      };
      window.cancelAnimationFrame = function () { };

      // jsdom has no canvas renderer: implement the tiny slice app.js uses
      const ctx = {
        createImageData: (w, hh) => ({ width: w, height: hh, data: new Uint8ClampedArray(w * hh * 4) }),
        putImageData: function (image) { this.__last = image; },
        getImageData: function (x, y, w, hh) {
          const src = this.__last ? this.__last.data : new Uint8ClampedArray(w * hh * 4);
          return { width: w, height: hh, data: new Uint8ClampedArray(src) };
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
      window.HTMLCanvasElement.prototype.toDataURL = function () { return 'data:image/png;base64,iVBORw0KGgo='; };
      window.matchMedia = window.matchMedia || (() => ({
        matches: false, addListener() { }, removeListener() { }, addEventListener() { }, removeEventListener() { }
      }));
    }
  });
  return dom;
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

/** Poll until app.js has finished its async boot. */
function waitBooted(window, tries) {
  tries = tries === undefined ? 300 : tries;
  return new Promise((resolve) => {
    const check = () => {
      const app = window.SNESApp;
      if (app && app.snapshot().booted) return resolve(true);
      if (tries-- <= 0) return resolve(false);
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

function key(window, type, code, keyCode) {
  const ev = new window.KeyboardEvent(type, { bubbles: true, cancelable: true, key: code, code: code });
  Object.defineProperty(ev, 'keyCode', { get: () => keyCode });
  Object.defineProperty(ev, 'which', { get: () => keyCode });
  window.dispatchEvent(ev);
}

function skyPixels(window) {
  const px = window.document.getElementById('canvas').getContext('2d')
    .getImageData(0, 0, 256, 240).data;
  let sky = 0;
  for (let i = 0; i < px.length; i += 4) {
    if (px[i + 2] > 200 && px[i] < 160 && px[i + 1] < 170) sky++;
  }
  return sky;
}

/** Start World 1-1 through the UI pad. */
function startMario(window) {
  pump(window, 100);
  press(window, 'start', 8);
  pump(window, 60);
  press(window, 'start', 8);
  pump(window, 240);
}

module.exports = {
  name: 'Web UI (index.html + app.js in a real DOM)',
  tests: {
    'index.html boots the wasm core and starts the game': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      t.ok(window.document.getElementById('canvas'), 'the game canvas exists');
      const ok = await waitBooted(window);
      t.ok(ok, 'window.SNESApp must report a booted machine');
      const snap = window.SNESApp.snapshot();
      t.ok(snap.running, 'the emulator is running after boot');
      t.equal(snap.error, null, 'no boot error: ' + snap.error);
      pump(window, 120);
      const after = window.SNESApp.snapshot();
      t.greater(after.frames, 20, 'frames are being emulated');
      t.greater(after.colors, 2, 'the canvas has real picture data');
      t.greater(after.audio, 0, 'audio samples are flowing to the UI');
      dom.window.close();
    },

    'the boot overlay is hidden once the ROM is running': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      const overlay = window.document.getElementById('overlay');
      t.ok(overlay && overlay.hidden === true, 'loading overlay must be hidden');
      t.match(window.SNESApp.status(), /.+/, 'status text is shown');
      dom.window.close();
    },

    'on-screen pad buttons reach the game (START boots World 1-1)': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      startMario(window);
      const snap = window.SNESApp.snapshot();
      t.greater(snap.frames, 300, 'the game advanced through the menus (' + snap.frames + ' frames)');
      t.greater(snap.colors, 5, 'World 1-1 should be rendered (colors: ' + snap.colors + ')');
      t.greater(skyPixels(window), 10000, 'the canvas really shows the World 1-1 sky');
      dom.window.close();
    },

    'holding RIGHT on the pad moves Mario': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      startMario(window);
      const before = window.SNESApp.snapshot().hash;
      hold(window, 'right', 2);
      pump(window, 90);
      release(window, 'right', 2);
      pump(window, 4);
      const after = window.SNESApp.snapshot().hash;
      t.notEqual(before, after, 'the frame must change while RIGHT is held');
      dom.window.close();
    },

    'keyboard controls work (Enter = START)': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      pump(window, 100);
      key(window, 'keydown', 'Enter', 13);
      pump(window, 8);
      key(window, 'keyup', 'Enter', 13);
      pump(window, 60);
      key(window, 'keydown', 'Enter', 13);
      pump(window, 8);
      key(window, 'keyup', 'Enter', 13);
      pump(window, 260);
      t.greater(window.SNESApp.snapshot().colors, 5, 'Enter started the game');
      dom.window.close();
    },

    'menu sheet opens, saves and restores a state': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped');
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      pump(window, 60);

      click(window, 'btn-menu');
      pump(window, 2);
      const sheet = window.document.getElementById('menu-sheet');
      t.ok(sheet && sheet.hidden === false, 'the menu sheet opens');

      click(window, 'mi-save');
      pump(window, 2);
      const stored = window.localStorage.getItem('bitvaultengine.state.v1');
      t.ok(stored && stored.length > 100, 'a save state was stored');

      click(window, 'mi-load');
      pump(window, 10);
      t.equal(window.SNESApp.snapshot().error, null, 'loading a state must not break the app');
      t.ok(window.SNESApp.isRunning(), 'the game is running again after loading');
      dom.window.close();
    },

    'the app never reaches the network': (t) => {
      const html = fs.readFileSync(path.join(WWW, 'index.html'), 'utf8');
      const app = fs.readFileSync(path.join(WWW, 'js', 'app.js'), 'utf8');
      t.notMatch(html, /https?:\/\//, 'no remote URLs in index.html');
      t.notMatch(app, /https?:\/\//, 'no remote URLs in app.js');
      t.notMatch(html + app, /cdn\.|unpkg|jsdelivr|googleapis/i, 'no CDN references');
    }
  }
};

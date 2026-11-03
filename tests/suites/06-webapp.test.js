/**
 * The real UI in a real DOM.
 *
 * The other suites exercise the core directly. This one boots index.html inside
 * jsdom — the same HTML the phone loads — lets app.js pull the wasm core and the
 * ROM through the same fetch() path it uses on Android, then plays the game by
 * dispatching DOM events on the on-screen pad and checks the canvas.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const h = require('../helpers');
const dom = require('../dom');

const WWW = path.join(h.ROOT, 'emulator', 'www');
const jsdom = dom.requireJsdom();
if (!jsdom && process.env.REQUIRE_JSDOM) {
  throw new Error('jsdom is required in this environment but could not be loaded: ' +
    dom.jsdomUnavailableReason());
}
const bootPage = () => dom.bootPage(WWW);
const { pump, waitBooted, hold, release, press, click, startMario, skyPixels } = dom;

function key(window, type, code, keyCode) {
  const ev = new window.KeyboardEvent(type, { bubbles: true, cancelable: true, key: code, code: code });
  Object.defineProperty(ev, 'keyCode', { get: () => keyCode });
  Object.defineProperty(ev, 'which', { get: () => keyCode });
  window.dispatchEvent(ev);
}

module.exports = {
  name: 'Web UI (index.html + app.js in a real DOM)',
  tests: {
    'index.html boots the wasm core and starts the game': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
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
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
      const dom = bootPage();
      const window = dom.window;
      await waitBooted(window);
      const overlay = window.document.getElementById('overlay');
      t.ok(overlay && overlay.hidden === true, 'loading overlay must be hidden');
      t.match(window.SNESApp.status(), /.+/, 'status text is shown');
      dom.window.close();
    },

    'on-screen pad buttons reach the game (START boots World 1-1)': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
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
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
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
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
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
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
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

    'the in-app self-test passes inside the real UI': async (t) => {
      if (!jsdom) return t.ok(true, 'jsdom not installed, skipped: ' + dom.jsdomUnavailableReason());
      const page = bootPage();
      const window = page.window;
      await waitBooted(window);
      pump(window, 30);

      click(window, 'btn-menu');
      pump(window, 2);
      click(window, 'mi-selftest');
      t.ok(window.SNESApp.selfTestVisible(), 'the self-test panel opens');

      const results = await window.SNESApp.selfTest();
      t.equal(results.length >= 12, true, 'the self-test runs every check (' + results.length + ')');
      const failed = results.filter((r) => !r.ok);
      t.equal(failed.length, 0, 'failed checks: ' + failed.map((r) => r.name + ' (' + r.detail + ')').join(', '));
      const verdict = window.document.getElementById('selftest-verdict');
      await new Promise((r) => setTimeout(r, 200));
      t.equal(verdict.getAttribute('data-state'), 'pass', 'the panel shows a pass verdict');
      window.close();
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

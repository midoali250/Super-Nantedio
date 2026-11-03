/**
 * ROM & packaging tests — the file we ship must be the file we tested, and the
 * Android build must contain exactly the web app we ship.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const h = require('../helpers');

const ROM_MD5 = '2041ef14c3d0f86b62e424f28bf6db2a';
const ASSETS = path.join(h.ROOT, 'android', 'app', 'src', 'main', 'assets');

function md5(buf) {
  return crypto.createHash('md5').update(buf).digest('hex');
}

function walk(dir, base, out) {
  out = out || {};
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = base ? base + '/' + entry.name : entry.name;
    if (entry.isDirectory()) walk(full, rel, out);
    else out[rel] = md5(fs.readFileSync(full));
  }
  return out;
}

module.exports = {
  name: 'ROM & packaged assets',
  tests: {
    'the ROM is present and is a valid iNES file': (t) => {
      t.ok(fs.existsSync(h.ROM_PATH), 'ROM missing: ' + h.ROM_PATH);
      const bytes = h.romBytes();
      t.equal(bytes.length, 196624, 'ROM size');
      t.equal(bytes[0], 0x4e); // 'N'
      t.equal(bytes[1], 0x45); // 'E'
      t.equal(bytes[2], 0x53); // 'S'
      t.equal(bytes[3], 0x1a);
    },

    'the ROM is the exact dump we validated (md5)': (t) => {
      t.equal(md5(fs.readFileSync(h.ROM_PATH)), ROM_MD5);
    },

    'the ROM header describes an MMC1 multicart': (t) => {
      const Core = h.loadCore();
      const hd = Core.parseHeader(h.romBytes());
      t.equal(hd.valid, true);
      t.equal(hd.mapper, 1, 'mapper 1 = MMC1');
      t.equal(hd.prgRomBytes, 131072, '128 KB PRG');
      t.equal(hd.chrRomBytes, 65536, '64 KB CHR');
      t.equal(hd.sizeMatches, true, 'header size matches the file size');
      t.equal(hd.mirroring, 'horizontal');
    },

    'parseHeader rejects junk': (t) => {
      const Core = h.loadCore();
      t.equal(Core.parseHeader(new Uint8Array(4)).valid, false);
      t.equal(Core.parseHeader(new Uint8Array(100)).valid, false);
      const bad = new Uint8Array(1024);
      bad[0] = 0x41;
      t.equal(Core.parseHeader(bad).valid, false);
    },

    'the wasm core ships with its licence and is the pinned build': (t) => {
      const wasm = fs.readFileSync(h.WASM_PATH);
      t.equal(wasm.length, 148799, 'sen_bg.wasm size');
      t.equal(wasm[0], 0x00);
      t.equal(wasm[1], 0x61);   // "\0asm"
      t.equal(wasm[2], 0x73);
      t.equal(wasm[3], 0x6d);
      t.ok(fs.existsSync(path.join(h.WWW, 'js', 'vendor', 'sen.README.md')), 'licence/readme present');
      const glue = fs.readFileSync(h.SEN_PATH, 'utf8');
      t.match(glue, /root\.SEN = \{ Emulator/, 'the glue exposes SEN as a classic script');
      t.notMatch(glue, /^\s*export /m, 'no ES-module exports (a WebView cannot load them)');
    },

    'the legacy jsnes core is gone': (t) => {
      t.ok(!fs.existsSync(path.join(h.WWW, 'js', 'vendor', 'jsnes.min.js')), 'jsnes.min.js still present');
      const app = fs.readFileSync(path.join(h.WWW, 'index.html'), 'utf8');
      t.notMatch(app, /jsnes/, 'index.html must not reference jsnes');
    },

    'JavaScript app files in the APK match the tested ones': (t) => {
      const web = {
        'index.html': path.join(h.WWW, 'index.html'),
        'css/app.css': path.join(h.WWW, 'css', 'app.css'),
        'js/app.js': path.join(h.WWW, 'js', 'app.js'),
        'js/nescore.js': path.join(h.WWW, 'js', 'nescore.js'),
        'js/vendor/sen.global.js': path.join(h.WWW, 'js', 'vendor', 'sen.global.js'),
        'js/vendor/sen_bg.wasm': path.join(h.WWW, 'js', 'vendor', 'sen_bg.wasm')
      };
      for (const [rel, src] of Object.entries(web)) {
        const dst = path.join(ASSETS, rel);
        t.ok(fs.existsSync(dst), 'missing in APK assets: ' + rel);
        t.equal(md5(fs.readFileSync(dst)), md5(fs.readFileSync(src)),
          rel + ' differs between emulator/www and the APK assets (run tools/sync_web_assets.sh)');
      }
      const romInApk = path.join(ASSETS, 'games', path.basename(h.ROM_PATH));
      t.ok(fs.existsSync(romInApk), 'the ROM must be bundled in the APK');
      t.equal(md5(fs.readFileSync(romInApk)), ROM_MD5, 'bundled ROM must be the tested dump');
    },

    'the APK assets contain no stale files': (t) => {
      const files = Object.keys(walk(ASSETS));
      t.ok(!files.includes('emulator.html'), 'stale emulator.html still shipped');
      const stray = files.filter((f) => f.endsWith('.nes') && !f.startsWith('games/'));
      t.equal(stray.length, 0, 'stray ROMs at the assets root: ' + stray.join(', '));
      t.ok(files.includes('js/vendor/sen_bg.wasm'));
      t.ok(files.includes('games/' + path.basename(h.ROM_PATH)));
      t.equal(files.length, 8, 'assets should hold exactly the 8 app files, found ' + files.length);
    },

    'index.html loads the local core only (works offline)': (t) => {
      const html = fs.readFileSync(path.join(h.WWW, 'index.html'), 'utf8');
      const scripts = [...html.matchAll(/<script[^>]*src="([^"]+)"/g)].map((m) => m[1]);
      t.equal(scripts.length, 3, 'expected three local scripts, found ' + scripts.length);
      for (const src of scripts) {
        t.ok(!/^https?:/.test(src), 'remote script: ' + src);
        t.ok(fs.existsSync(path.join(h.WWW, src)), 'missing script: ' + src);
      }
      t.notMatch(html, /https?:\/\//, 'index.html must not reference any network URL');
    },

    'app.js never depends on the network or file:// fetch tricks': (t) => {
      const src = fs.readFileSync(path.join(h.WWW, 'js', 'app.js'), 'utf8');
      t.notMatch(src, /https?:\/\//, 'no absolute URLs in app.js');
      t.match(src, /fetch\(/, 'the app fetches the wasm + ROM through fetch()');
      t.match(src, /AndroidBridge/, 'with a bridge fallback for restricted WebViews');
      t.notMatch(src, /document\.write/, 'no document.write');
    }
  }
};

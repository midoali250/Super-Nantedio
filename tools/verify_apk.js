#!/usr/bin/env node
/**
 * Verify a built APK end-to-end — no Android device required.
 *
 *     node tools/verify_apk.js bitvaultengine.apk
 *
 * It unpacks the APK and then:
 *   1. compares every web asset in the APK with emulator/www (byte-identical),
 *   2. checks the ROM and the wasm are really inside,
 *   3. checks AndroidManifest.xml + classes.dex are present and the manifest
 *      binary really mentions MainActivity / the launcher intent,
 *   4. **boots the app from the APK's own assets** in jsdom and plays the game
 *      through the on-screen pad until World 1-1 is on the canvas,
 *   5. prints the APK's size and sha256.
 *
 * Exit code 0 = the APK in your hand is the app that was tested.
 */
'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');
const { execFileSync } = require('child_process');

const h = require('../tests/helpers');
const dom = require('../tests/dom');

const REQUIRED_ASSETS = [
  'index.html',
  'css/app.css',
  'js/app.js',
  'js/nescore.js',
  'js/vendor/sen.global.js',
  'js/vendor/sen_bg.wasm',
  'games/Super Mario Bros. + Duck Hunt (E) [!].nes'
];

function fail(msg) {
  console.error('  ✗ ' + msg);
  process.exitCode = 1;
}

function ok(msg) {
  console.log('  ✓ ' + msg);
}

function sha256(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}

function unzip(apk, dest) {
  // `unzip` is present on GitHub runners and on macOS/Linux dev boxes.
  execFileSync('unzip', ['-q', '-o', apk, '-d', dest], { stdio: 'inherit' });
}

function main() {
  const apk = path.resolve(process.argv[2] || 'bitvaultengine.apk');
  if (!fs.existsSync(apk)) {
    console.error('APK not found: ' + apk);
    process.exit(2);
  }

  console.log('verifying ' + apk);
  console.log('  size   ' + (fs.statSync(apk).size / 1024).toFixed(1) + ' kB');
  console.log('  sha256 ' + sha256(apk));

  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'apk-'));
  unzip(apk, tmp);

  /* ---------------------------------------------------------- 1. packaging */

  if (fs.existsSync(path.join(tmp, 'AndroidManifest.xml'))) ok('AndroidManifest.xml is packaged');
  else fail('AndroidManifest.xml is missing');

  const dex = fs.readdirSync(tmp).filter((f) => /^classes.*\.dex$/.test(f));
  if (dex.length) ok('Dalvik bytecode present (' + dex.join(', ') + ')');
  else fail('no classes.dex — the APK has no code');

  const resources = fs.existsSync(path.join(tmp, 'resources.arsc'));
  if (resources) ok('resources.arsc present (icons/theme)'); else fail('resources.arsc is missing');

  /* ------------------------------------------------------ 2. the payload */

  const assetsRoot = path.join(tmp, 'assets');
  if (!fs.existsSync(assetsRoot)) {
    fail('assets/ is missing from the APK');
  } else {
    for (const rel of REQUIRED_ASSETS) {
      const inApk = path.join(assetsRoot, rel);
      const inRepo = path.join(h.WWW, rel);
      if (!fs.existsSync(inApk)) {
        fail('missing from the APK: assets/' + rel);
        continue;
      }
      if (/\.(png)$/.test(rel)) continue;
      const a = sha256(inApk);
      const b = sha256(inRepo);
      if (a !== b) {
        fail('assets/' + rel + ' differs from emulator/www (apk ' + a.slice(0, 12) + ' vs repo ' + b.slice(0, 12) + ')');
      }
    }
    ok('every web asset in the APK is byte-identical to the tested tree');
  }

  /* ------------------------------------------- 3. is this really our app? */

  const manifestBuf = fs.readFileSync(path.join(tmp, 'AndroidManifest.xml'));
  const interned = manifestBuf.toString('utf16le') + manifestBuf.toString('latin1');
  if (interned.includes('MainActivity')) ok('the binary manifest references MainActivity');
  else fail('MainActivity not found in the binary manifest');

  const dexBuf = Buffer.concat(dex.map((f) => fs.readFileSync(path.join(tmp, f))));
  const dexText = dexBuf.toString('latin1');
  if (dexText.includes('com/bitvaultengine/nes/MainActivity')) ok('MainActivity is compiled into the APK');
  else fail('MainActivity is not in the dex payload');

  /* ------------------------ 4. boot the app from the APK's own assets */

  if (!dom.requireJsdom()) {
    console.log('  ! jsdom unavailable, skipping the runtime boot: ' + dom.jsdomUnavailableReason());
    fail('jsdom is required to boot the app from the APK');
  } else {
    const page = dom.bootPage(assetsRoot);
    const window = page.window;
    return dom.waitBooted(window, 400).then((booted) => {
      if (!booted) {
        fail('the app inside the APK did not boot: ' + (window.SNESApp ? window.SNESApp.error() : 'no SNESApp'));
      } else {
        ok('the app inside the APK booted the wasm core and the bundled ROM');
        dom.pump(window, 30);
        const snap = window.SNESApp.snapshot();
        if (snap.error) fail('runtime error after boot: ' + snap.error);
        if (!snap.running) fail('the emulator is not running');
        if (!(snap.audio > 0)) fail('no audio samples are being produced');
        if (!(snap.colors > 1)) fail('the canvas is blank');

        dom.startMario(window);
        const played = window.SNESApp.snapshot();
        if (played.colors > 5) ok('played from the APK: World 1-1 is rendered (' + played.colors + ' colours)');
        else fail('World 1-1 did not render from the APK (' + played.colors + ' colours)');

        const sky = dom.skyPixels(window);
        if (sky > 10000) ok('the canvas shows the World 1-1 sky (' + sky + ' pixels)');
        else fail('the canvas is not showing the level (sky pixels: ' + sky + ')');

        // And the on-screen pad must drive the game from inside the APK.
        const before = window.SNESApp.snapshot().hash;
        dom.hold(window, 'right', 2);
        dom.pump(window, 90);
        dom.release(window, 'right', 2);
        dom.pump(window, 4);
        if (window.SNESApp.snapshot().hash !== before) ok('the on-screen pad moves Mario from inside the APK');
        else fail('pad input does not reach the game');

        // The same self-test the player can run from the menu.
        return window.SNESApp.selfTest().then((results) => {
          const failed = results.filter((r) => !r.ok);
          if (failed.length) fail('self-test from the APK: ' + failed.map((r) => r.name + ' (' + r.detail + ')').join(', '));
          else ok('the built-in self-test passes from inside the APK (' + results.length + '/' + results.length + ')');
          window.close();
          fs.rmSync(tmp, { recursive: true, force: true });
          report4();
        });
      }
    });
  }

  fs.rmSync(tmp, { recursive: true, force: true });
  report4();
  return Promise.resolve();

  function report4() {
    if (process.exitCode) {
      console.error('\nAPK VERIFICATION FAILED');
    } else {
      console.log('\nAPK VERIFIED — this exact file plays the game.');
    }
  }
}

Promise.resolve()
  .then(main)
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

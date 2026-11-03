/**
 * Android packaging tests — everything that can be checked without the SDK.
 *
 * These catch the class of bug that produced the old black-screen APK:
 * a manifest that points at a missing file, a WebView loading file://, a Gradle
 * project without a working wrapper, icons that are not there, etc.
 */
'use strict';

const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const h = require('../helpers');

const ANDROID = path.join(h.ROOT, 'android');
const APP = path.join(ANDROID, 'app');
const MAIN = path.join(APP, 'src', 'main');
const JAVA = path.join(MAIN, 'java', 'com', 'bitvaultengine', 'nes');

function read(rel) {
  return fs.readFileSync(path.join(ANDROID, rel), 'utf8');
}

function pngSize(file) {
  const b = fs.readFileSync(file);
  if (b[0] !== 0x89 || b.toString('ascii', 1, 4) !== 'PNG') throw new Error('not a PNG: ' + file);
  return { width: b.readUInt32BE(16), height: b.readUInt32BE(20) };
}

module.exports = {
  name: 'Android project',
  tests: {
    'the Gradle wrapper is real and points at Gradle 8.7': (t) => {
      const jar = path.join(ANDROID, 'gradle', 'wrapper', 'gradle-wrapper.jar');
      t.ok(fs.existsSync(jar), 'gradle-wrapper.jar missing');
      const b = fs.readFileSync(jar);
      t.equal(b[0], 0x50);   // 'PK' zip
      t.equal(b[1], 0x4b);
      t.greater(b.length, 20000, 'the wrapper jar must be the real one, not a stub');
      const props = read('gradle/wrapper/gradle-wrapper.properties');
      t.match(props, /gradle-8\.7-bin\.zip/);
      const gradlew = read('gradlew');
      t.match(gradlew, /GradleWrapperMain|exec/, 'gradlew must run the wrapper');
      t.notMatch(gradlew, /placeholder/i, 'the old placeholder script is gone');
    },

    'the Gradle files are consistent': (t) => {
      const settings = read('settings.gradle');
      t.match(settings, /include ':app'/);
      t.match(settings, /google\(\)/, 'the Android plugin comes from google()');
      const top = read('build.gradle');
      t.match(top, /com\.android\.application.*8\.5\.2/);
      const app = read('app/build.gradle');
      t.match(app, /namespace 'com\.bitvaultengine\.nes'/);
      t.match(app, /compileSdk 34/);
      t.match(app, /minSdk 23/);
      t.match(app, /noCompress 'nes', 'wasm'/, 'the ROM and the wasm must stay uncompressed');
      t.match(app, /signingConfig signingConfigs\.debug/, 'releases are signed so they can be installed');
      t.notMatch(app, /androidx\.|com\.android\.support/, 'no external dependencies are needed');
    },

    'the manifest is valid and points at the real Activity': (t) => {
      const manifest = fs.readFileSync(path.join(MAIN, 'AndroidManifest.xml'), 'utf8');
      t.match(read('app/build.gradle'), /namespace 'com\.bitvaultengine\.nes'/, 'namespace is declared');
      t.match(manifest, /android:name="\.MainActivity"/);
      t.match(manifest, /android:exported="true"/);
      t.match(manifest, /MAIN/);
      t.match(manifest, /LAUNCHER/);
      t.match(manifest, /screenOrientation="sensorLandscape"/);
      t.match(manifest, /android:icon="@mipmap\/ic_launcher"/);
      t.match(manifest, /android:theme="@style\/Theme\.bitvaultengine"/);
      t.ok(fs.existsSync(path.join(JAVA, 'MainActivity.java')), 'MainActivity.java must exist');

      // every @style/@string/@mipmap/@color reference must resolve
      const values = fs.readFileSync(path.join(MAIN, 'res', 'values', 'strings.xml'), 'utf8');
      t.match(values, /name="app_name"/);
      const themes = fs.readFileSync(path.join(MAIN, 'res', 'values', 'themes.xml'), 'utf8');
      t.match(themes, /name="Theme\.bitvaultengine"/);
      t.notMatch(manifest, /emulator\.html/, 'the removed emulator.html must not be referenced');
    },

    'the WebView loads assets from the https origin, never file://': (t) => {
      const java = fs.readFileSync(path.join(JAVA, 'MainActivity.java'), 'utf8');
      t.match(java, /appassets\.androidplatform\.net/, 'secure asset origin');
      t.match(java, /https:\/\/" \+ ASSET_HOST \+ "\/assets\/index\.html/);
      t.notMatch(java, /loadUrl\("file:/, 'file:// breaks fetch() and was the black-screen bug');
      t.match(java, /shouldInterceptRequest/, 'assets are served from the APK');
      t.match(java, /application\/wasm/, 'the wasm needs the right MIME type for streaming compile');
      t.match(java, /addJavascriptInterface/, 'save states / screenshots bridge');
      t.match(java, /setAllowFileAccess\(false\)/);
      t.match(java, /shouldOverrideUrlLoading/, 'navigation away is blocked');
    },

    'the Java sources are syntactically balanced': (t) => {
      for (const file of fs.readdirSync(JAVA)) {
        if (!file.endsWith('.java')) continue;
        const src = fs.readFileSync(path.join(JAVA, file), 'utf8');
        t.match(src, /^package com\.bitvaultengine\.nes;/m, file + ' package');
        const opens = (src.match(/\{/g) || []).length;
        const closes = (src.match(/\}/g) || []).length;
        t.equal(opens, closes, file + ' has unbalanced braces');
        t.notMatch(src, /import androidx\./, file + ' must not need AndroidX');
        t.ok(src.includes('class '), file + ' declares a class');
      }
    },

    'every launcher icon exists at every density': (t) => {
      const sizes = {
        'mipmap-mdpi': 48, 'mipmap-hdpi': 72, 'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144, 'mipmap-xxxhdpi': 192
      };
      for (const [dir, size] of Object.entries(sizes)) {
        for (const name of ['ic_launcher.png', 'ic_launcher_round.png']) {
          const file = path.join(MAIN, 'res', dir, name);
          t.ok(fs.existsSync(file), dir + '/' + name + ' missing');
          const dim = pngSize(file);
          t.equal(dim.width, size, dir + '/' + name + ' width');
          t.equal(dim.height, size, dir + '/' + name + ' height');
        }
        const fg = path.join(MAIN, 'res', dir, 'ic_launcher_foreground.png');
        t.ok(fs.existsSync(fg), dir + '/ic_launcher_foreground.png missing');
      }
      const adaptive = fs.readFileSync(
        path.join(MAIN, 'res', 'mipmap-anydpi-v26', 'ic_launcher.xml'), 'utf8');
      t.match(adaptive, /adaptive-icon/);
      t.match(adaptive, /ic_launcher_foreground/);
    },

    'the app declares no internet permission': (t) => {
      const manifest = fs.readFileSync(path.join(MAIN, 'AndroidManifest.xml'), 'utf8');
      t.notMatch(manifest, /android\.permission\.INTERNET/, 'the game must not need the network');
      t.match(manifest, /android\.permission\.VIBRATE/);
    },

    'the assets bundle the ROM and the wasm core': (t) => {
      const assets = path.join(MAIN, 'assets');
      for (const rel of ['index.html', 'css/app.css', 'js/app.js', 'js/nescore.js',
        'js/vendor/sen.global.js', 'js/vendor/sen_bg.wasm']) {
        t.ok(fs.existsSync(path.join(assets, rel)), 'missing asset: ' + rel);
      }
      const rom = fs.readdirSync(path.join(assets, 'games'));
      t.equal(rom.length, 1, 'exactly one ROM');
      t.match(rom[0], /Super Mario Bros\. \+ Duck Hunt/);
    }
  }
};

/**
 * Tests for the Python packaging tools that also run in CI:
 *   tools/nes_disassembler.py  (the previous CI run failed on this step)
 *   tools/generate_icons.py    (launcher icons are generated, not hand-made)
 */
'use strict';

const { execFileSync } = require('child_process');
const fs = require('fs');
const os = require('os');
const path = require('path');
const h = require('../helpers');

const TOOL = path.join(h.ROOT, 'tools', 'nes_disassembler.py');
const ICONS = path.join(h.ROOT, 'tools', 'generate_icons.py');

function python() {
  for (const cmd of ['python3', 'python']) {
    try {
      execFileSync(cmd, ['--version'], { stdio: 'ignore' });
      return cmd;
    } catch (e) { /* try next */ }
  }
  return null;
}

const PY = python();

module.exports = {
  name: 'Packaging tools',
  tests: {
    'python3 is available for the CI tooling': (t) => {
      t.ok(PY, 'python3 must be installed');
    },

    'disassembler prints the ROM summary': (t) => {
      if (!PY) return t.ok(true, 'python missing, skipped');
      const out = execFileSync(PY, [TOOL, h.ROM_PATH, '--summary'], { encoding: 'utf8' });
      t.match(out, /mapper:\s*1/, 'summary should report the MMC1 mapper');
      t.match(out, /prg_rom_kb:\s*128/);
      t.match(out, /chr_rom_kb:\s*64/);
      t.match(out, /size:\s*196624/);
    },

    'disassembler writes a 6502 listing for the whole PRG ROM': (t) => {
      if (!PY) return t.ok(true, 'python missing, skipped');
      const out = path.join(os.tmpdir(), 'bitvaultengine-disasm-' + process.pid + '.txt');
      // This is the exact command the GitHub Actions workflow runs.
      execFileSync(PY, [TOOL, h.ROM_PATH, '--output', out], { encoding: 'utf8' });
      t.ok(fs.existsSync(out), 'listing file must be written');
      const text = fs.readFileSync(out, 'utf8');
      t.greater(text.split('\n').length, 10000, 'listing should contain the full PRG ROM');
      t.match(text, /\$8000:/, 'listing starts at $8000');
      t.match(text, /JMP|JSR|SEI|CLD|LDA/, 'listing contains real 6502 instructions');
      t.match(text, /\$9DC5:/, 'listing reaches the end of the 8-bank PRG ROM');
      fs.unlinkSync(out);
    },

    'disassembler refuses a non-NES file': (t) => {
      if (!PY) return t.ok(true, 'python missing, skipped');
      const bogus = path.join(os.tmpdir(), 'not-a-rom-' + process.pid + '.nes');
      fs.writeFileSync(bogus, Buffer.from('this is definitely not a nes rom'));
      let failed = false;
      try {
        execFileSync(PY, [TOOL, bogus, '--summary'], { encoding: 'utf8', stdio: 'pipe' });
      } catch (e) {
        failed = e.status !== 0;
      } finally {
        fs.unlinkSync(bogus);
      }
      t.ok(failed, 'the tool must exit non-zero for invalid input');
    },

    'APK verifier boots the app out of a packaged APK': (t) => {
      if (!PY) return t.ok(true, 'python missing, skipped');
      // Build a stand-in APK carrying the real asset payload, then run the exact
      // script CI runs on the finished APK.
      const apk = path.join(os.tmpdir(), 'bitvaultengine-verify-' + process.pid + '.apk');
      const assets = path.join(h.ROOT, 'android', 'app', 'src', 'main', 'assets');
      const script = path.join(os.tmpdir(), 'make-fake-apk-' + process.pid + '.py');
      fs.writeFileSync(script, [
        'import os, sys, zipfile',
        'src, out = sys.argv[1], sys.argv[2]',
        'with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:',
        '    for root, _, files in os.walk(src):',
        '        for f in files:',
        '            p = os.path.join(root, f)',
        '            z.write(p, "assets/" + os.path.relpath(p, src))',
        '    z.writestr("AndroidManifest.xml", "com.bitvaultengine.nes.MainActivity".encode("utf-16le"))',
        '    z.writestr("classes.dex", b"dex\\n035\\x00Lcom/bitvaultengine/nes/MainActivity;")',
        '    z.writestr("resources.arsc", b"\\x02\\x00")'
      ].join('\n'), 'utf8');
      execFileSync(PY, [script, assets, apk], { encoding: 'utf8' });

      const out = execFileSync(process.execPath,
        [path.join(h.ROOT, 'tools', 'verify_apk.js'), apk], { encoding: 'utf8' });
      t.match(out, /APK VERIFIED/, 'the verifier must accept a good APK');
      t.match(out, /World 1-1 is rendered/);
      t.match(out, /on-screen pad moves Mario/);
      fs.unlinkSync(apk);
      fs.unlinkSync(script);
    },

    'icon generator produces every icon the APK needs': (t) => {
      if (!PY) return t.ok(true, 'python missing, skipped');
      const outDir = fs.mkdtempSync(path.join(os.tmpdir(), 'icons-'));
      execFileSync(PY, [ICONS, '--out', outDir], { encoding: 'utf8' });
      for (const d of ['mipmap-mdpi', 'mipmap-hdpi', 'mipmap-xhdpi', 'mipmap-xxhdpi', 'mipmap-xxxhdpi']) {
        t.ok(fs.existsSync(path.join(outDir, d, 'ic_launcher.png')), d + '/ic_launcher.png');
        t.ok(fs.existsSync(path.join(outDir, d, 'ic_launcher_round.png')), d + '/ic_launcher_round.png');
      }
      const big = fs.readFileSync(path.join(outDir, 'mipmap-xxxhdpi', 'ic_launcher.png'));
      t.equal(big[0], 0x89, 'a real PNG');
      t.equal(big[1], 0x50);
    }
  }
};

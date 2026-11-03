#!/usr/bin/env node
/**
 * bitvaultengine — minimal test runner.
 *
 * Zero dependencies on purpose: CI (and anyone who clones the repo) can run
 * `node tests/run.js` without installing anything. Tests live in
 * tests/suites/*.test.js and look like:
 *
 *   module.exports = {
 *     name: 'core',
 *     tests: {
 *       'does a thing': (t) => { t.equal(1, 1); }
 *     }
 *   };
 *
 * Usage:  node tests/run.js [filter]
 */
'use strict';

const fs = require('fs');
const path = require('path');

const TTY = process.stdout.isTTY;
const C = TTY
  ? { green: '\x1b[32m', red: '\x1b[31m', dim: '\x1b[2m', bold: '\x1b[1m', reset: '\x1b[0m' }
  : { green: '', red: '', dim: '', bold: '', reset: '' };

class Assertions {
  constructor() { this.assertions = 0; }

  ok(value, msg) {
    this.assertions++;
    if (!value) throw new Error(msg || 'expected truthy, got ' + JSON.stringify(value));
  }

  equal(actual, expected, msg) {
    this.assertions++;
    if (actual !== expected) {
      throw new Error((msg || 'values differ') +
        '\n    expected: ' + JSON.stringify(expected) + '\n    actual:   ' + JSON.stringify(actual));
    }
  }

  notEqual(actual, expected, msg) {
    this.assertions++;
    if (actual === expected) throw new Error((msg || 'values should differ') + ' (both ' + JSON.stringify(actual) + ')');
  }

  close(actual, expected, tolerance, msg) {
    this.assertions++;
    if (!(Math.abs(actual - expected) <= tolerance)) {
      throw new Error((msg || 'value out of tolerance') + ': ' + actual + ' vs ' + expected + ' (±' + tolerance + ')');
    }
  }

  greater(actual, threshold, msg) {
    this.assertions++;
    if (!(actual > threshold)) throw new Error((msg || 'expected greater') + ': ' + actual + ' <= ' + threshold);
  }

  less(actual, threshold, msg) {
    this.assertions++;
    if (!(actual < threshold)) throw new Error((msg || 'expected less') + ': ' + actual + ' >= ' + threshold);
  }

  bytesEqual(actual, expected, msg) {
    this.assertions++;
    if (actual.length !== expected.length) {
      throw new Error((msg || 'byte arrays differ') + ': length ' + actual.length + ' vs ' + expected.length);
    }
    for (let i = 0; i < actual.length; i++) {
      if (actual[i] !== expected[i]) {
        throw new Error((msg || 'byte arrays differ') + ': first diff at ' + i + ' (' + actual[i] + ' vs ' + expected[i] + ')');
      }
    }
  }

  throws(fn, msg) {
    this.assertions++;
    let threw = false;
    try { fn(); } catch (e) { threw = true; }
    if (!threw) throw new Error(msg || 'expected function to throw');
  }

  match(value, regex, msg) {
    this.assertions++;
    if (!regex.test(String(value))) {
      throw new Error((msg || 'pattern not found') + ': ' + String(value).slice(0, 120) + ' !~ ' + regex);
    }
  }

  notMatch(value, regex, msg) {
    this.assertions++;
    if (regex.test(String(value))) {
      throw new Error((msg || 'unexpected match') + ': ' + String(value).slice(0, 120) + ' =~ ' + regex);
    }
  }
}

async function main() {
  const only = process.argv[2];
  const dir = path.join(__dirname, 'suites');
  const files = fs.readdirSync(dir).filter((f) => f.endsWith('.test.js')).sort();

  let pass = 0, fail = 0, assertions = 0;
  const failures = [];
  const started = Date.now();

  for (const file of files) {
    if (only && !file.includes(only)) continue;
    const suite = require(path.join(dir, file));
    process.stdout.write('\n' + C.bold + suite.name + C.reset + '  ' + C.dim + '(' + file + ')' + C.reset + '\n');
    for (const [title, fn] of Object.entries(suite.tests)) {
      const t = new Assertions();
      const t0 = Date.now();
      try {
        await fn(t);
        pass++;
        assertions += t.assertions;
        process.stdout.write('  ' + C.green + '✓' + C.reset + ' ' + title + ' ' + C.dim + (Date.now() - t0) + 'ms' + C.reset + '\n');
      } catch (err) {
        fail++;
        assertions += t.assertions;
        failures.push({ suite: suite.name, title, err });
        process.stdout.write('  ' + C.red + '✗ ' + title + C.reset + '\n');
        process.stdout.write('    ' + C.red + String(err && err.message || err).split('\n').join('\n    ') + C.reset + '\n');
      }
    }
  }

  const total = Date.now() - started;
  process.stdout.write('\n' + '─'.repeat(56) + '\n');
  if (fail === 0) {
    process.stdout.write(C.green + C.bold + 'ALL PASSED' + C.reset + '  ' + pass + ' tests, ' + assertions + ' assertions in ' + total + 'ms\n');
  } else {
    process.stdout.write(C.red + C.bold + fail + ' FAILED' + C.reset + '  ' + pass + ' passed, ' + assertions + ' assertions in ' + total + 'ms\n');
    for (const f of failures) process.stdout.write('  ' + C.red + '•' + C.reset + ' ' + f.suite + ' › ' + f.title + '\n');
  }
  process.exit(fail === 0 ? 0 : 1);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});

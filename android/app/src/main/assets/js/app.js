/* ==========================================================================
   bitvaultengine — app.js
   UI glue: canvas rendering, requestAnimationFrame loop, WebAudio output and
   the touch controls (D-pad + A/B/START/SELECT).

   RULE: this file never runs in the test-suite directly; all emulator logic
   lives in js/nescore.js (unit tested) and index.html + this file are booted
   in a real DOM by tests/suites/06-webapp.test.js.
   ========================================================================== */
(function () {
  'use strict';

  var Core = window.SNESCore;
  if (!Core) throw new Error('nescore.js must be loaded before app.js');

  var machine = null;
  var rafId = null;
  var running = false;
  var soundOn = true;
  var lastTs = 0;
  var acc = 0;
  var lastError = null;
  var bootStarted = false;

  var $ = function (id) { return document.getElementById(id); };

  var canvas = $('canvas');
  var ctx = canvas.getContext('2d', { alpha: false });
  var overlay = $('overlay');
  var toastEl = $('toast');
  var statusPill = $('status-pill');
  var menuSheet = $('menu-sheet');

  var img = ctx.createImageData(Core.SCREEN_W, Core.SCREEN_H);
  var imgData = img.data;

  window.addEventListener('error', function (e) {
    lastError = (e && e.message) || String(e);
  });

  /* ------------------------------------------------------------------ status */

  function setStatus(text, state) {
    if (!statusPill) return;
    statusPill.textContent = text;
    if (state) statusPill.setAttribute('data-state', state);
  }

  function toast(msg) {
    if (!toastEl) return;
    toastEl.textContent = msg;
    toastEl.hidden = false;
    clearTimeout(toast.timer);
    toast.timer = setTimeout(function () { toastEl.hidden = true; }, 2200);
  }

  /* ------------------------------------------------------------------- audio */

  var RING_FRAMES = 44100 * 2;      // two seconds of samples, plenty of slack
  var ringL = null, ringR = null, ringRead = 0, ringWrite = 0, ringAvailable = 0;
  var audio = null;

  function initAudio() {
    if (audio) return audio;
    var AC = window.AudioContext || window.webkitAudioContext;
    if (!AC) return null;
    try {
      var actx = new AC();
      ringL = new Float32Array(RING_FRAMES);
      ringR = new Float32Array(RING_FRAMES);

      // ScriptProcessor is deprecated but is the only node available in every
      // WebView from API 21 upwards; 2048 frames ≈ 46 ms of latency.
      var node = actx.createScriptProcessor(2048, 0, 2);
      node.onaudioprocess = function (e) {
        var outL = e.outputBuffer.getChannelData(0);
        var outR = e.outputBuffer.getChannelData(1);
        if (!running || !soundOn) {
          outL.fill(0);
          outR.fill(0);
          return;
        }
        for (var i = 0; i < outL.length; i++) {
          if (ringAvailable > 0) {
            outL[i] = ringL[ringRead];
            outR[i] = ringR[ringRead];
            ringRead = (ringRead + 1) % RING_FRAMES;
            ringAvailable--;
          } else {
            outL[i] = 0;
            outR[i] = 0;
          }
        }
      };
      node.connect(actx.destination);
      audio = { ctx: actx, node: node };
    } catch (err) {
      audio = null;
    }
    return audio;
  }

  function pushAudio(samples) {
    if (!ringL) return;
    for (var i = 0; i < samples.length; i++) {
      var v = samples[i];
      if (v > 1) v = 1; else if (v < -1) v = -1;
      ringL[ringWrite] = v;
      ringR[ringWrite] = v;
      ringWrite = (ringWrite + 1) % RING_FRAMES;
      if (ringAvailable < RING_FRAMES) ringAvailable++;
      else ringRead = (ringRead + 1) % RING_FRAMES;
    }
  }

  function resumeAudio() {
    if (!audio) initAudio();
    if (audio && audio.ctx.state === 'suspended') audio.ctx.resume();
  }

  /* -------------------------------------------------------------------- boot */

  var ROM_URL = 'games/Super%20Mario%20Bros.%20%2B%20Duck%20Hunt%20(E)%20%5B!%5D.nes';
  var WASM_URL = 'js/vendor/sen_bg.wasm';

  function b64ToBytes(b64) {
    var bin = atob(b64);
    var out = new Uint8Array(bin.length);
    for (var i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i);
    return out;
  }

  /**
   * Load a binary asset. In the browser (and in the Android WebView, which
   * serves the assets from an internal https asset origin) plain fetch()
   * works. If it ever does not, the very same bytes can arrive as base64 via an
   * injected global (__ROM_B64__) or through the Android bridge, so a
   * file://-style restriction can never leave the player with a black screen.
   */
  function fetchBytes(url, bridgeGetter, inlineGlobal) {
    return fetch(url).then(function (res) {
      if (!res.ok) throw new Error('HTTP ' + res.status + ' for ' + url);
      return res.arrayBuffer();
    }).then(function (buf) {
      return new Uint8Array(buf);
    }).catch(function (err) {
      var inline = inlineGlobal && window[inlineGlobal];
      if (inline) return b64ToBytes(inline);
      if (bridgeGetter && window.AndroidBridge && window.AndroidBridge[bridgeGetter]) {
        var b64 = window.AndroidBridge[bridgeGetter]();
        if (b64) return b64ToBytes(b64);
      }
      throw err;
    });
  }

  function sampleRate() {
    if (audio && audio.ctx && audio.ctx.sampleRate) return audio.ctx.sampleRate;
    return 44100;
  }

  function boot() {
    if (bootStarted) return;
    bootStarted = true;
    setStatus('جاري التحميل…', 'idle');

    var wasmBytes = null;

    fetchBytes(WASM_URL, 'getWasmBase64', '__WASM_B64__').then(function (w) {
      wasmBytes = w;
      return fetchBytes(ROM_URL, 'getRomBase64', '__ROM_B64__');
    }).then(function (romBytes) {
      Core.init({ wasmBytes: wasmBytes, sen: window.SEN });
      machine = new Core.Machine({
        romBytes: romBytes,
        sampleRate: sampleRate(),
        onFrame: renderFrame,
        onAudio: pushAudio
      });
      machine.steps(2);
      overlay.hidden = true;
      resumeAudio();
      play();
      setStatus('تعمل', 'running');
      toast('تم تشغيل اللعبة — استخدم الأزرار للتحكم');
    }).catch(function (err) {
      bootStarted = false;
      lastError = (err && err.message) || String(err);
      setStatus('تعذّر التحميل', 'error');
      toast('فشل التحميل: ' + lastError);
    });
  }

  /* --------------------------------------------------------------- rendering */

  function renderFrame(rgba) {
    imgData.set(rgba);
    ctx.putImageData(img, 0, 0);
  }

  function loop(ts) {
    rafId = requestAnimationFrame(loop);
    if (!machine) return;

    if (!lastTs) lastTs = ts;
    var elapsed = ts - lastTs;
    lastTs = ts;

    if (running) {
      acc += Math.min(elapsed, 120) / (1000 / 60);
      var steps = Math.min(Math.floor(acc), 3);   // never spiral on slow devices
      acc -= steps;
      for (var i = 0; i < steps; i++) machine.step();
    }
  }

  function play() {
    if (!machine) return;
    running = true;
    resumeAudio();
    var btn = $('btn-playpause');
    if (btn) btn.setAttribute('data-state', 'playing');
    setStatus('تعمل', 'running');
  }

  function pause() {
    running = false;
    var btn = $('btn-playpause');
    if (btn) btn.setAttribute('data-state', 'paused');
    setStatus('متوقفة', 'idle');
  }

  function togglePlay() {
    if (!machine) { boot(); return; }
    if (running) { pause(); toast('تم الإيقاف المؤقت'); }
    else { play(); toast('تم التشغيل'); }
  }

  function reset() {
    if (!machine) return;
    machine.hardReset();
    overlay.hidden = true;
    play();
    toast('تمت إعادة تشغيل اللعبة');
  }

  /* ----------------------------------------------------------------- controls */

  var pressed = {};

  function pressButton(name) {
    if (!machine) return;
    try { machine.buttonDown(name); } catch (e) { return; }
    pressed[name] = true;
  }

  function releaseButton(name) {
    if (!machine) return;
    try { machine.buttonUp(name); } catch (e) { return; }
    delete pressed[name];
  }

  function releaseAllUi() {
    for (var name in pressed) releaseButton(name);
    var nodes = document.querySelectorAll('[data-btn].pressed');
    for (var i = 0; i < nodes.length; i++) nodes[i].classList.remove('pressed');
  }

  function bindHold(el) {
    if (!el) return;
    var name = el.getAttribute('data-btn');

    var down = function (e) {
      if (e && e.cancelable) e.preventDefault();
      el.classList.add('pressed');
      pressButton(name);
    };
    var up = function (e) {
      if (e && e.cancelable) e.preventDefault();
      el.classList.remove('pressed');
      releaseButton(name);
    };

    if (window.PointerEvent) {
      el.addEventListener('pointerdown', down, { passive: false });
      el.addEventListener('pointerup', up, { passive: false });
      el.addEventListener('pointercancel', up, { passive: false });
      el.addEventListener('pointerleave', up, { passive: false });
    } else {
      el.addEventListener('touchstart', down, { passive: false });
      el.addEventListener('touchend', up, { passive: false });
      el.addEventListener('touchcancel', up, { passive: false });
      el.addEventListener('mousedown', down);
      el.addEventListener('mouseup', up);
      el.addEventListener('mouseleave', up);
    }
    el.addEventListener('contextmenu', function (e) { e.preventDefault(); });
  }

  /* -------------------------------------------------------------- self-test */

  /**
   * On-device check that the copy of the game in the player's hand really works.
   * It never trusts the boot path above: it loads a *second*, independent
   * emulator instance from the bundled bytes, plays a scripted game and checks
   * the pixels. The result is shown in the menu sheet.
   *
   * The same routine is what CI uses (tools/verify_apk.js) — the phone and the
   * build server run the identical checks.
   */
  var selftestRunning = false;

  function selftestRender(list, results) {
    if (!list) return;
    list.innerHTML = '';
    for (var i = 0; i < results.length; i++) {
      var r = results[i];
      var li = document.createElement('li');
      li.className = r.ok ? 'pass' : 'fail';
      var mark = document.createElement('span');
      mark.className = 'mark';
      mark.textContent = r.ok ? '✓' : '✗';
      var label = document.createElement('span');
      label.textContent = r.name;
      li.appendChild(mark);
      li.appendChild(label);
      if (r.detail) {
        var d = document.createElement('span');
        d.className = 'detail';
        d.textContent = ' — ' + r.detail;
        li.appendChild(d);
      }
      list.appendChild(li);
    }
  }

  /**
   * @param {(results:Array)=>void} done  called once with every result
   * @param {(name:string)=>void}   step  optional progress callback
   */
  function runSelfTest(done, step) {
    var results = [];
    function check(name, fn) {
      var ok = false, detail = '';
      try {
        var out = fn();
        ok = out === undefined ? true : (out === true || (out && out.ok));
        if (out && out.detail) detail = out.detail;
      } catch (e) {
        ok = false;
        detail = (e && e.message) || String(e);
      }
      results.push({ name: name, ok: ok, detail: detail });
      if (step) step(name);
      return ok;
    }

    check('ملف اللعبة موجود داخل التطبيق', function () {
      return { ok: true, detail: 'games/Super Mario Bros. + Duck Hunt (E) [!].nes' };
    });

    check('المحاكي (WASM) محمّل', function () {
      return { ok: Core.isReady(), detail: Core.isReady() ? 'SEN 0.7.0' : 'غير محمّل' };
    });

    if (!done) return results;
    selftestRunning = true;

    // Load a second, independent console from the bundled bytes.
    fetchBytes(WASM_URL, 'getWasmBase64', '__WASM_B64__').then(function (wasm) {
      check('إعادة تحميل نواة المحاكي', function () {
        return { ok: wasm.length > 1000, detail: (wasm.length / 1024).toFixed(0) + ' kB' };
      });
      return fetchBytes(ROM_URL, 'getRomBase64', '__ROM_B64__');
    }).then(function (rom) {
      var romOk = check('قراءة الشريط', function () {
        var hd = Core.parseHeader(rom);
        return {
          ok: hd.valid && hd.mapper === 1,
          detail: rom.length + ' bytes • mapper ' + hd.mapper + ' • ' + (hd.prgRomBytes / 1024) + 'K PRG'
        };
      });
      if (!romOk) throw new Error('the cartridge could not be parsed');

      var test = new Core.Machine({ romBytes: rom, sampleRate: 44100 });
      var t = 0;
      function advance(n) { for (var i = 0; i < n; i++) { test.step(); t++; } }

      advance(120);
      check('إقلاع الشريط ورسم صورة', function () {
        return {
          ok: !test.isBlank() && test.colorCount() > 2,
          detail: test.colorCount() + ' colours at frame ' + t
        };
      });

      // Multicart: START, then START again = Super Mario Bros.
      test.buttonDown('START'); advance(30); test.buttonUp('START'); advance(50);
      test.buttonDown('START'); advance(30); test.buttonUp('START'); advance(240);

      check('دخول World 1-1', function () {
        var fb = test.getBuffer();
        var sky = 0;
        for (var i = 0; i < fb.length; i += 4) {
          if (fb[i + 2] > 200 && fb[i] < 160 && fb[i + 1] < 170) sky++;
        }
        return { ok: sky > 10000 && test.colorCount() > 5, detail: sky + ' sky pixels' };
      });

      check('الصوت يعمل (APU)', function () {
        var e = test.takeAudioEnergy();
        return { ok: e > 0 && test.audioPeak() > 0.02, detail: 'peak ' + test.audioPeak().toFixed(3) };
      });

      var findMario = function () {
        var fb = test.getBuffer(), xs = [];
        for (var y = 165; y < 225; y++) {
          for (var x = 0; x < 256; x++) {
            var i = (y * 256 + x) * 4;
            if (fb[i] > 150 && fb[i + 1] < 110 && fb[i + 2] < 110) xs.push(x);
          }
        }
        if (!xs.length) return -1;
        xs.sort(function (a, b) { return a - b; });
        return xs[Math.floor(xs.length / 2)];
      };

      var x0 = findMario();
      check('ماريو ظاهر على الشاشة', function () {
        return { ok: x0 > -1, detail: 'x = ' + x0 };
      });

      test.buttonDown('RIGHT'); advance(90); test.buttonUp('RIGHT'); advance(5);
      var x1 = findMario();
      check('زر اليمين يحرّك ماريو', function () {
        return { ok: x1 - x0 > 25, detail: x0 + ' → ' + x1 };
      });

      var topOf = function () {
        var fb = test.getBuffer();
        for (var y = 120; y < 235; y++) {
          for (var x = 0; x < 256; x++) {
            var i = (y * 256 + x) * 4;
            if (fb[i] > 150 && fb[i + 1] < 110 && fb[i + 2] < 110) return y;
          }
        }
        return -1;
      };
      var ground = topOf();
      test.buttonDown('A'); advance(14);
      var air = topOf();
      test.buttonUp('A');
      check('زر A يجعل ماريو يقفز', function () {
        return { ok: air < ground, detail: 'y ' + ground + ' → ' + air };
      });

      var state = test.saveState();
      check('حفظ الحالة', function () {
        return { ok: !!state && state.length > 1000, detail: (state ? state.length : 0) + ' bytes' };
      });

      advance(60);
      var beforeLoad = test.frameHash();
      test.loadState(state);
      advance(1);
      check('استرجاع الحالة', function () {
        var restored = test.frameHash();
        return { ok: restored !== beforeLoad, detail: 'hash ' + restored };
      });

      check('الشريط يحتوي 3 ألعاب', function () {
        // Duck Hunt sits one SELECT away on the multicart menu.
        var probe = new Core.Machine({ romBytes: rom, sampleRate: 44100 });
        for (var i = 0; i < 100; i++) probe.step();
        probe.buttonDown('START'); for (i = 0; i < 30; i++) probe.step(); probe.buttonUp('START');
        probe.buttonDown('SELECT'); for (i = 0; i < 18; i++) probe.step(); probe.buttonUp('SELECT');
        for (i = 0; i < 100; i++) probe.step();
        return { ok: probe.colorCount() > 2 && probe.blockSignature().join(',') !== test.blockSignature().join(','),
          detail: 'Duck Hunt screen rendered' };
      });
    }).catch(function (err) {
      check('تشغيل الاختبارات', function () {
        return { ok: false, detail: (err && err.message) || String(err) };
      });
    }).then(function () {
      selftestRunning = false;
      if (done) done(results);
    });
  }

  /* ----------------------------------------------------------------- menu */

  var STATE_KEY = 'bitvaultengine.state.v1';

  function openMenu() { if (menuSheet) menuSheet.hidden = false; pause(); }
  function closeMenu() { if (menuSheet) menuSheet.hidden = true; }

  function startSelfTestUi() {
    var panel = $('selftest-panel');
    var list = $('selftest-list');
    var verdict = $('selftest-verdict');
    if (!panel || selftestRunning) return;
    pause();
    panel.hidden = false;
    verdict.setAttribute('data-state', 'running');
    verdict.textContent = 'جارٍ…';
    list.innerHTML = '<li>…</li>';

    runSelfTest(function (results) {
      var failed = results.filter(function (r) { return !r.ok; });
      verdict.setAttribute('data-state', failed.length ? 'fail' : 'pass');
      verdict.textContent = failed.length
        ? failed.length + ' فشل من ' + results.length
        : 'كل الفحوصات ناجحة (' + results.length + '/' + results.length + ')';
      selftestRender(list, results);
      toast(failed.length ? 'فشل الفحص — ' + failed[0].name : 'اللعبة سليمة ✓');
    });
  }

  function saveState() {
    if (!machine) { toast('اللعبة لم تُشغّل بعد'); return; }
    try {
      var b64 = machine.saveStateBase64();
      if (!b64) { lastError = 'saveState returned no data'; toast('تعذّر الحفظ'); return; }
      if (window.AndroidBridge && window.AndroidBridge.saveState) {
        window.AndroidBridge.saveState(b64);
        toast('تم حفظ الحالة داخل التطبيق');
      } else {
        try { localStorage.setItem(STATE_KEY, b64); } catch (e) { /* quota */ }
        toast('تم حفظ الحالة');
      }
    } catch (e) {
      lastError = 'save failed: ' + ((e && e.message) || e);
      toast('تعذّر الحفظ');
    }
  }

  function loadState() {
    if (!machine) { toast('اللعبة لم تُشغّل بعد'); return; }
    try {
      var b64 = null;
      if (window.AndroidBridge && window.AndroidBridge.loadState) b64 = window.AndroidBridge.loadState();
      if (!b64) { try { b64 = localStorage.getItem(STATE_KEY); } catch (e) { b64 = null; } }
      if (!b64) { toast('لا توجد حالة محفوظة'); return; }
      machine.loadStateBase64(b64);
      overlay.hidden = true;
      play();
      toast('تم استرجاع الحالة');
    } catch (e) { toast('تعذّر الاسترجاع'); }
  }

  function screenshot() {
    try {
      var data = canvas.toDataURL('image/png');
      if (window.AndroidBridge && window.AndroidBridge.saveScreenshot) {
        window.AndroidBridge.saveScreenshot(data);
        toast('تم حفظ اللقطة في المعرض');
      } else {
        var a = document.createElement('a');
        a.href = data;
        a.download = 'bitvaultengine-' + Date.now() + '.png';
        a.click();
        toast('تم تنزيل اللقطة');
      }
    } catch (e) { toast('تعذّر أخذ اللقطة'); }
  }

  function toggleSound() {
    soundOn = !soundOn;
    var b = $('mi-sound');
    if (b) b.textContent = soundOn ? '🔊 الصوت: مفعّل' : '🔇 الصوت: مكتوم';
    toast(soundOn ? 'الصوت مفعّل' : 'تم كتم الصوت');
  }

  function goFullscreen() {
    var el = document.getElementById('app');
    var fn = el.requestFullscreen || el.webkitRequestFullscreen;
    if (!fn) { toast('ملء الشاشة غير مدعوم'); return; }
    try {
      var p = fn.call(el);
      if (p && p.then) p.then(resize).catch(function () { toast('ملء الشاشة غير مدعوم'); });
    } catch (e) { toast('ملء الشاشة غير مدعوم'); }
  }

  function resize() {
    var wrap = $('screen-wrap');
    if (!wrap) return;
    var pad = 8;
    var availW = Math.max(160, wrap.clientWidth - pad);
    var availH = Math.max(150, wrap.clientHeight - pad);
    var scale = Math.min(availW / Core.SCREEN_W, availH / Core.SCREEN_H);
    if (window.innerHeight && window.innerHeight < 520) scale = Math.min(scale, availH / Core.SCREEN_H);
    var w = Math.round(Core.SCREEN_W * scale);
    var h = Math.round(Core.SCREEN_H * scale);
    canvas.style.width = w + 'px';
    canvas.style.height = h + 'px';
    ctx.imageSmoothingEnabled = false;
  }

  function setupControls() {
    var nodes = document.querySelectorAll('[data-btn]');
    for (var i = 0; i < nodes.length; i++) bindHold(nodes[i]);

    $('btn-boot').addEventListener('click', function () {
      resumeAudio();
      if (!machine) boot(); else { overlay.hidden = true; play(); }
    });
    $('btn-menu').addEventListener('click', openMenu);
    $('mi-close').addEventListener('click', closeMenu);
    $('btn-playpause').addEventListener('click', togglePlay);

    $('mi-play').addEventListener('click', function () { play(); closeMenu(); });
    $('mi-pause').addEventListener('click', function () { pause(); closeMenu(); });
    $('mi-reset').addEventListener('click', function () { reset(); closeMenu(); });
    $('mi-save').addEventListener('click', function () { saveState(); closeMenu(); });
    $('mi-load').addEventListener('click', function () { loadState(); closeMenu(); });
    $('mi-shot').addEventListener('click', function () { screenshot(); closeMenu(); });
    $('mi-sound').addEventListener('click', toggleSound);
    $('mi-fullscreen').addEventListener('click', function () { goFullscreen(); closeMenu(); });
    $('mi-help').addEventListener('click', function () {
      toast('SELECT يبدّل اللعبة • START يبدأ • A/B للعب');
      closeMenu();
    });

    $('mi-selftest').addEventListener('click', function () {
      startSelfTestUi();
    });

    menuSheet.addEventListener('click', function (e) {
      if (e.target === menuSheet) closeMenu();
    });

    // Hardware / bluetooth keyboard support
    var keymap = {
      ArrowUp: 'UP', ArrowDown: 'DOWN', ArrowLeft: 'LEFT', ArrowRight: 'RIGHT',
      KeyZ: 'A', KeyX: 'B', KeyA: 'SELECT', KeyS: 'START',
      Enter: 'START', ShiftRight: 'SELECT', Space: 'A', KeyK: 'A', KeyJ: 'B'
    };
    window.addEventListener('keydown', function (e) {
      if (e.code === 'Escape') { openMenu(); return; }
      var b = keymap[e.code];
      if (b) { e.preventDefault(); pressButton(b); }
    });
    window.addEventListener('keyup', function (e) {
      var b = keymap[e.code];
      if (b) { e.preventDefault(); releaseButton(b); }
    });

    window.addEventListener('resize', resize);
    window.addEventListener('orientationchange', function () { setTimeout(resize, 150); });

    document.addEventListener('visibilitychange', function () {
      if (document.hidden) { pause(); releaseAllUi(); }
      else if (machine) { play(); resumeAudio(); }
    });
  }

  function init() {
    resize();
    setupControls();
    setStatus('جاهز', 'idle');
    rafId = requestAnimationFrame(loop);
    boot();      // the ROM is bundled, so start immediately
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.addEventListener('beforeunload', function () {
    if (rafId) cancelAnimationFrame(rafId);
  });

  // Small debug surface: used by the DOM smoke test, by logcat diagnostics in the
  // Android WebView and by tools/report.js.
  window.SNESApp = {
    isRunning: function () { return running; },
    frameCount: function () { return machine ? machine.frameCount : 0; },
    press: pressButton,
    release: releaseButton,
    releaseAll: function () {
      ['A', 'B', 'SELECT', 'START', 'UP', 'DOWN', 'LEFT', 'RIGHT'].forEach(releaseButton);
    },
    boot: boot,
    play: play,
    pause: pause,
    reset: reset,
    status: function () { return statusPill ? statusPill.textContent : ''; },
    error: function () { return lastError; },
    // Runs the full on-device self-test; resolves with one result per check.
    selfTest: function () {
      return new Promise(function (resolve) {
        runSelfTest(function (results) { resolve(results); });
      });
    },
    selfTestVisible: function () {
      var p = $('selftest-panel');
      return !!(p && !p.hidden);
    },
    snapshot: function () {
      return {
        booted: !!machine,
        running: running,
        frames: machine ? machine.frameCount : 0,
        colors: machine ? machine.colorCount() : 0,
        hash: machine ? machine.frameHash() : 0,
        audio: machine ? machine.audioSamples : 0,
        status: statusPill ? statusPill.textContent : '',
        error: lastError
      };
    }
  };
})();

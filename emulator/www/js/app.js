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

  /* ----------------------------------------------------------------- menu */

  var STATE_KEY = 'bitvaultengine.state.v1';

  function openMenu() { if (menuSheet) menuSheet.hidden = false; pause(); }
  function closeMenu() { if (menuSheet) menuSheet.hidden = true; }

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

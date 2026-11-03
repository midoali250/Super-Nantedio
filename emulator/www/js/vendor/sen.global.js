/* SEN — https://github.com/lukad/sen (MIT license)
 * wasm-bindgen glue, converted from an ES module to a classic script so a
 * WebView can load it from index.html without ES-module restrictions.
 * Only three mechanical edits: `export` keywords removed, the module object
 * exposed as window.SEN, and the default wasm URL replaced by an explicit
 * error (the app always passes the wasm bytes it loaded).
 * Upstream: @lukad/sen 0.7.0 — do not hand-edit. See docs/EMULATOR.md. */
(function (root) {
'use strict';
/* @ts-self-types="./sen.d.ts" */

/**
 * A self-contained NES emulator.
 *
 * Create an emulator from an iNES ROM, call `runFrame()` to advance it, then
 * read the video and audio produced by that frame. Call `free()` when the
 * instance is no longer needed.
 */
class Emulator {
    __destroy_into_raw() {
        const ptr = this.__wbg_ptr;
        this.__wbg_ptr = 0;
        EmulatorFinalization.unregister(this);
        return ptr;
    }
    free() {
        const ptr = this.__destroy_into_raw();
        wasm.__wbg_emulator_free(ptr, 0);
    }
    /**
     * Returns a copy of the current video frame as row-major RGBA bytes.
     *
     * The returned array contains `frameWidth() * frameHeight() * 4` bytes and
     * can be copied directly into an `ImageData` object's `data` array.
     * @returns {Uint8Array}
     */
    frameBuffer() {
        const ret = wasm.emulator_frameBuffer(this.__wbg_ptr);
        return ret;
    }
    /**
     * Returns the video frame height in pixels.
     * @returns {number}
     */
    frameHeight() {
        const ret = wasm.emulator_frameHeight(this.__wbg_ptr);
        return ret >>> 0;
    }
    /**
     * Returns the video frame width in pixels.
     * @returns {number}
     */
    frameWidth() {
        const ret = wasm.emulator_frameWidth(this.__wbg_ptr);
        return ret >>> 0;
    }
    /**
     * Restores the current cartridge's battery-backed save RAM.
     *
     * Throws an `Error` if the ROM has no battery-backed RAM or if `ram` has
     * the wrong length for the cartridge.
     * @param {Uint8Array} ram
     */
    loadSaveRam(ram) {
        const ptr0 = passArray8ToWasm0(ram, wasm.__wbindgen_malloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.emulator_loadSaveRam(this.__wbg_ptr, ptr0, len0);
        if (ret[1]) {
            throw takeFromExternrefTable0(ret[0]);
        }
    }
    /**
     * Restores a state created by `saveState()`.
     *
     * Throws for corrupt data, a different ROM/sample rate, or an unsupported
     * state version. Failed loads leave the emulator unchanged.
     * @param {Uint8Array} image
     */
    loadState(image) {
        const ptr0 = passArray8ToWasm0(image, wasm.__wbindgen_malloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.emulator_loadState(this.__wbg_ptr, ptr0, len0);
        if (ret[1]) {
            throw takeFromExternrefTable0(ret[0]);
        }
    }
    /**
     * Creates an emulator loaded with an iNES ROM.
     *
     * `sample_rate` is the output audio sample rate in hertz, usually
     * `AudioContext.sampleRate`. Throws an `Error` if `rom` is invalid or uses
     * an unsupported mapper.
     * @param {Uint8Array} rom
     * @param {number} sample_rate
     */
    constructor(rom, sample_rate) {
        const ptr0 = passArray8ToWasm0(rom, wasm.__wbindgen_malloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.emulator_new(ptr0, len0, sample_rate);
        if (ret[2]) {
            throw takeFromExternrefTable0(ret[1]);
        }
        this.__wbg_ptr = ret[0];
        EmulatorFinalization.register(this, this.__wbg_ptr, this);
        return this;
    }
    /**
     * Replaces the current game with a new iNES ROM.
     *
     * This starts the new game from power-on state and discards queued audio.
     * `sample_rate` is in hertz. Throws an `Error` if `rom` is invalid or uses
     * an unsupported mapper.
     * @param {Uint8Array} rom
     * @param {number} sample_rate
     */
    reset(rom, sample_rate) {
        const ptr0 = passArray8ToWasm0(rom, wasm.__wbindgen_malloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.emulator_reset(this.__wbg_ptr, ptr0, len0, sample_rate);
        if (ret[1]) {
            throw takeFromExternrefTable0(ret[0]);
        }
    }
    /**
     * Advances emulation until the next complete video frame.
     *
     * After calling this method, use `frameBuffer()` to read the new frame and
     * `takeAudio()` to drain the audio samples generated so far.
     */
    runFrame() {
        wasm.emulator_runFrame(this.__wbg_ptr);
    }
    /**
     * Returns a copy of the current cartridge's battery-backed save RAM.
     *
     * Throws an `Error` when the loaded ROM does not declare battery-backed
     * RAM. Persist the returned bytes and restore them with `loadSaveRam()`.
     * @returns {Uint8Array}
     */
    saveRam() {
        const ret = wasm.emulator_saveRam(this.__wbg_ptr);
        if (ret[2]) {
            throw takeFromExternrefTable0(ret[1]);
        }
        return takeFromExternrefTable0(ret[0]);
    }
    /**
     * Returns an opaque copy of the emulator's current state.
     *
     * The state can be restored with `loadState()`.
     * @returns {Uint8Array}
     */
    saveState() {
        const ret = wasm.emulator_saveState(this.__wbg_ptr);
        if (ret[2]) {
            throw takeFromExternrefTable0(ret[1]);
        }
        return takeFromExternrefTable0(ret[0]);
    }
    /**
     * Sets the buttons currently held on controller 1.
     *
     * Combine buttons with bitwise OR:
     * A = `1 << 0`
     * B = `1 << 1`
     * Select = `1 << 2`
     * Start = `1 << 3`
     * Up = `1 << 4`
     * Down = `1 << 5`
     * Left = `1 << 6`
     * Right = `1 << 7`.
     *
     * Pass `0` to release every button.
     * @param {number} mask
     */
    setController1(mask) {
        wasm.emulator_setController1(this.__wbg_ptr, mask);
    }
    /**
     * Sets the buttons currently held on controller 2.
     *
     * Uses the same button mask as `setController1()`. Pass `0` to release
     * every button.
     * @param {number} mask
     */
    setController2(mask) {
        wasm.emulator_setController2(this.__wbg_ptr, mask);
    }
    /**
     * Replaces all active Game Genie codes.
     *
     * Each entry must be a six- or eight-character NES Game Genie code.
     * Passing an empty array disables all cheats. If any entry is invalid,
     * the active codes remain unchanged.
     * @param {string[]} codes
     */
    setGameGenieCodes(codes) {
        const ptr0 = passArrayJsValueToWasm0(codes, wasm.__wbindgen_malloc);
        const len0 = WASM_VECTOR_LEN;
        const ret = wasm.emulator_setGameGenieCodes(this.__wbg_ptr, ptr0, len0);
        if (ret[1]) {
            throw takeFromExternrefTable0(ret[0]);
        }
    }
    /**
     * Returns all queued mono audio samples and clears the audio queue.
     *
     * Samples are 32-bit floating-point values at the sample rate passed to
     * the constructor or the most recent call to `reset()`.
     * @returns {Float32Array}
     */
    takeAudio() {
        const ret = wasm.emulator_takeAudio(this.__wbg_ptr);
        return ret;
    }
}
if (Symbol.dispose) Emulator.prototype[Symbol.dispose] = Emulator.prototype.free;
function __wbg_get_imports() {
    const import0 = {
        __proto__: null,
        __wbg___wbindgen_string_get_b0ca35b86a603356: function(arg0, arg1) {
            const obj = arg1;
            const ret = typeof(obj) === 'string' ? obj : undefined;
            var ptr1 = isLikeNone(ret) ? 0 : passStringToWasm0(ret, wasm.__wbindgen_malloc, wasm.__wbindgen_realloc);
            var len1 = WASM_VECTOR_LEN;
            getDataViewMemory0().setInt32(arg0 + 4 * 1, len1, true);
            getDataViewMemory0().setInt32(arg0 + 4 * 0, ptr1, true);
        },
        __wbg___wbindgen_throw_344f42d3211c4765: function(arg0, arg1) {
            throw new Error(getStringFromWasm0(arg0, arg1));
        },
        __wbg_new_b667d279fd5aa943: function(arg0, arg1) {
            const ret = new Error(getStringFromWasm0(arg0, arg1));
            return ret;
        },
        __wbg_new_from_slice_77cdfb7977362f3c: function(arg0, arg1) {
            const ret = new Uint8Array(getArrayU8FromWasm0(arg0, arg1));
            return ret;
        },
        __wbg_new_from_slice_ddf8b82c4d6af38e: function(arg0, arg1) {
            const ret = new Float32Array(getArrayF32FromWasm0(arg0, arg1));
            return ret;
        },
        __wbindgen_init_externref_table: function() {
            const table = wasm.__wbindgen_externrefs;
            const offset = table.grow(4);
            table.set(0, undefined);
            table.set(offset + 0, undefined);
            table.set(offset + 1, null);
            table.set(offset + 2, true);
            table.set(offset + 3, false);
        },
    };
    return {
        __proto__: null,
        "./sen_bg.js": import0,
    };
}

const EmulatorFinalization = (typeof FinalizationRegistry === 'undefined')
    ? { register: () => {}, unregister: () => {} }
    : new FinalizationRegistry(ptr => wasm.__wbg_emulator_free(ptr, 1));

function addToExternrefTable0(obj) {
    const idx = wasm.__externref_table_alloc();
    wasm.__wbindgen_externrefs.set(idx, obj);
    return idx;
}

function getArrayF32FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getFloat32ArrayMemory0().subarray(ptr / 4, ptr / 4 + len);
}

function getArrayU8FromWasm0(ptr, len) {
    ptr = ptr >>> 0;
    return getUint8ArrayMemory0().subarray(ptr / 1, ptr / 1 + len);
}

let cachedDataViewMemory0 = null;
function getDataViewMemory0() {
    if (cachedDataViewMemory0 === null || cachedDataViewMemory0.buffer.detached === true || (cachedDataViewMemory0.buffer.detached === undefined && cachedDataViewMemory0.buffer !== wasm.memory.buffer)) {
        cachedDataViewMemory0 = new DataView(wasm.memory.buffer);
    }
    return cachedDataViewMemory0;
}

let cachedFloat32ArrayMemory0 = null;
function getFloat32ArrayMemory0() {
    if (cachedFloat32ArrayMemory0 === null || cachedFloat32ArrayMemory0.byteLength === 0) {
        cachedFloat32ArrayMemory0 = new Float32Array(wasm.memory.buffer);
    }
    return cachedFloat32ArrayMemory0;
}

function getStringFromWasm0(ptr, len) {
    return decodeText(ptr >>> 0, len);
}

let cachedUint8ArrayMemory0 = null;
function getUint8ArrayMemory0() {
    if (cachedUint8ArrayMemory0 === null || cachedUint8ArrayMemory0.byteLength === 0) {
        cachedUint8ArrayMemory0 = new Uint8Array(wasm.memory.buffer);
    }
    return cachedUint8ArrayMemory0;
}

function isLikeNone(x) {
    return x === undefined || x === null;
}

function passArray8ToWasm0(arg, malloc) {
    const ptr = malloc(arg.length * 1, 1) >>> 0;
    getUint8ArrayMemory0().set(arg, ptr / 1);
    WASM_VECTOR_LEN = arg.length;
    return ptr;
}

function passArrayJsValueToWasm0(array, malloc) {
    const ptr = malloc(array.length * 4, 4) >>> 0;
    for (let i = 0; i < array.length; i++) {
        const add = addToExternrefTable0(array[i]);
        getDataViewMemory0().setUint32(ptr + 4 * i, add, true);
    }
    WASM_VECTOR_LEN = array.length;
    return ptr;
}

function passStringToWasm0(arg, malloc, realloc) {
    if (realloc === undefined) {
        const buf = cachedTextEncoder.encode(arg);
        const ptr = malloc(buf.length, 1) >>> 0;
        getUint8ArrayMemory0().subarray(ptr, ptr + buf.length).set(buf);
        WASM_VECTOR_LEN = buf.length;
        return ptr;
    }

    let len = arg.length;
    let ptr = malloc(len, 1) >>> 0;

    const mem = getUint8ArrayMemory0();

    let offset = 0;

    for (; offset < len; offset++) {
        const code = arg.charCodeAt(offset);
        if (code > 0x7F) break;
        mem[ptr + offset] = code;
    }
    if (offset !== len) {
        if (offset !== 0) {
            arg = arg.slice(offset);
        }
        ptr = realloc(ptr, len, len = offset + arg.length * 3, 1) >>> 0;
        const view = getUint8ArrayMemory0().subarray(ptr + offset, ptr + len);
        const ret = cachedTextEncoder.encodeInto(arg, view);

        offset += ret.written;
        ptr = realloc(ptr, len, offset, 1) >>> 0;
    }

    WASM_VECTOR_LEN = offset;
    return ptr;
}

function takeFromExternrefTable0(idx) {
    const value = wasm.__wbindgen_externrefs.get(idx);
    wasm.__externref_table_dealloc(idx);
    return value;
}

let cachedTextDecoder = new TextDecoder('utf-8', { ignoreBOM: true, fatal: true });
cachedTextDecoder.decode();
const MAX_SAFARI_DECODE_BYTES = 2146435072;
let numBytesDecoded = 0;
function decodeText(ptr, len) {
    numBytesDecoded += len;
    if (numBytesDecoded >= MAX_SAFARI_DECODE_BYTES) {
        cachedTextDecoder = new TextDecoder('utf-8', { ignoreBOM: true, fatal: true });
        cachedTextDecoder.decode();
        numBytesDecoded = len;
    }
    return cachedTextDecoder.decode(getUint8ArrayMemory0().subarray(ptr, ptr + len));
}

const cachedTextEncoder = new TextEncoder();

if (!('encodeInto' in cachedTextEncoder)) {
    cachedTextEncoder.encodeInto = function (arg, view) {
        const buf = cachedTextEncoder.encode(arg);
        view.set(buf);
        return {
            read: arg.length,
            written: buf.length
        };
    };
}

let WASM_VECTOR_LEN = 0;

let wasmModule, wasmInstance, wasm;
function __wbg_finalize_init(instance, module) {
    wasmInstance = instance;
    wasm = instance.exports;
    wasmModule = module;
    cachedDataViewMemory0 = null;
    cachedFloat32ArrayMemory0 = null;
    cachedUint8ArrayMemory0 = null;
    wasm.__wbindgen_start();
    return wasm;
}

async function __wbg_load(module, imports) {
    if (typeof Response === 'function' && module instanceof Response) {
        if (typeof WebAssembly.instantiateStreaming === 'function') {
            try {
                return await WebAssembly.instantiateStreaming(module, imports);
            } catch (e) {
                const validResponse = module.ok && expectedResponseType(module.type);

                if (validResponse && module.headers.get('Content-Type') !== 'application/wasm') {
                    console.warn("`WebAssembly.instantiateStreaming` failed because your server does not serve Wasm with `application/wasm` MIME type. Falling back to `WebAssembly.instantiate` which is slower. Original error:\n", e);

                } else { throw e; }
            }
        }

        const bytes = await module.arrayBuffer();
        return await WebAssembly.instantiate(bytes, imports);
    } else {
        const instance = await WebAssembly.instantiate(module, imports);

        if (instance instanceof WebAssembly.Instance) {
            return { instance, module };
        } else {
            return instance;
        }
    }

    function expectedResponseType(type) {
        switch (type) {
            case 'basic': case 'cors': case 'default': return true;
        }
        return false;
    }
}

function initSync(module) {
    if (wasm !== undefined) return wasm;


    if (module !== undefined) {
        if (Object.getPrototypeOf(module) === Object.prototype) {
            ({module} = module)
        } else {
            console.warn('using deprecated parameters for `initSync()`; pass a single object instead')
        }
    }

    const imports = __wbg_get_imports();
    if (!(module instanceof WebAssembly.Module)) {
        module = new WebAssembly.Module(module);
    }
    const instance = new WebAssembly.Instance(module, imports);
    return __wbg_finalize_init(instance, module);
}

async function __wbg_init(module_or_path) {
    if (wasm !== undefined) return wasm;


    if (module_or_path !== undefined) {
        if (Object.getPrototypeOf(module_or_path) === Object.prototype) {
            ({module_or_path} = module_or_path)
        } else {
            console.warn('using deprecated parameters for the initialization function; pass a single object instead')
        }
    }

    if (module_or_path === undefined) {
        throw new Error('sen_bg.wasm must be supplied by the app');
    }
    const imports = __wbg_get_imports();

    if (typeof module_or_path === 'string' || (typeof Request === 'function' && module_or_path instanceof Request) || (typeof URL === 'function' && module_or_path instanceof URL)) {
        module_or_path = fetch(module_or_path);
    }

    const { instance, module } = await __wbg_load(await module_or_path, imports);

    return __wbg_finalize_init(instance, module);
}



root.SEN = { Emulator: Emulator, initSync: initSync, init: initSync };
})(typeof self !== 'undefined' ? self : this);

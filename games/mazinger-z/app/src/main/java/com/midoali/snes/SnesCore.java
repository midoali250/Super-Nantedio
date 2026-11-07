package com.midoali.snes;

/**
 * Thin JNI bridge to the embedded Snes9x 2010 (libretro) core.
 *
 * Mazinger Z is a Bandai SNES board that reads the standard Super Famicom pad:
 * four face buttons (B, Y, A, X), two shoulders (L, R), the D-pad and
 * START / SELECT. Every one of those ten game inputs is wired end to end here.
 */
public final class SnesCore {
    static {
        System.loadLibrary("snescore");
    }

    /* Video filter modes, mirrored from snes_jni.c */
    public static final int VIDEO_FILTER_HD_CRISP = 0;
    public static final int VIDEO_FILTER_SMOOTH = 1;
    public static final int VIDEO_FILTER_RAW_PIXEL = 2;

    /* Core option indexes */
    public static final int OPT_REGION = 0;
    public static final int OPT_INTERPOLATION = 1;
    public static final int OPT_ASPECT = 2;
    public static final int OPT_FRAMESKIP = 3;
    public static final int OPT_SPRITE_FLICKER = 4;
    public static final int OPT_OVERCLOCK = 5;

    /* Built-in cheat bits, mirrored from snes_jni.c */
    public static final int CHEAT_INF_LIVES = 1 << 0;
    public static final int CHEAT_INVINCIBLE = 1 << 1;
    public static final int CHEAT_MAX_POWER = 1 << 2;
    public static final int CHEAT_MOON_JUMP = 1 << 3;
    public static final int CHEAT_INF_TIME = 1 << 4;
    public static final int CHEAT_SUPER_SPEED = 1 << 5;
    public static final int CHEAT_RAPID_FIRE = 1 << 6;

    private SnesCore() { }

    /** Boots the ROM held in {@code rom}; {@code saveDir} is the app files dir. */
    public static native boolean nativeStart(byte[] rom, String saveDir);

    /** Flushes the cartridge SRAM to disk and tears the core down. */
    public static native void nativeStop();

    /** Runs exactly one video frame of the emulated console. */
    public static native void nativeRunFrame();

    public static native int nativeFrameWidth();

    public static native int nativeFrameHeight();

    /** Copies the latest RGB565 frame into a direct buffer; 1 on success. */
    public static native int nativeCopyVideo(java.nio.ByteBuffer buffer);

    /** Joypad bitmask using the libretro RETRO_DEVICE_ID_JOYPAD_* ids. */
    public static native void nativeSetInput(int mask);

    /** Drains queued stereo frames into {@code out}; returns frames written. */
    public static native int nativeReadAudio(short[] out, int maxFrames);

    public static native double nativeFps();

    public static native double nativeSampleRate();

    /** Soft-resets the console without reloading the ROM (Reset game). */
    public static native void nativeReset();

    /** 0 = True HD Crisp 4x, 1 = Ultra Smooth 4x, 2 = Raw Pixel 1x. */
    public static native void nativeSetVideoFilter(int mode);

    public static native int nativeGetVideoFilter();

    /** Enables/disables the built-in cheat bits (OR of CHEAT_* constants). */
    public static native void nativeSetCheats(int mask);

    public static native int nativeGetCheats();

    /**
     * Registers a Game Genie / Pro Action Replay / raw code with the core.
     * Passing a null code clears the whole list.
     */
    public static native int nativeApplyCheatCode(int index, boolean enabled, String code);

    /** Reads one byte of console WRAM (for the live cheat finder). */
    public static native int nativeReadRamByte(int address);

    /** Writes one byte of console WRAM. */
    public static native void nativeWriteRamByte(int address, int value);

    /** Live core option edit; the core picks it up on the next frame. */
    public static native void nativeSetCoreOption(int index, String value);

    public static native String nativeGetCoreOption(int index);

    /** Serialises the machine into {@code out}; returns bytes written. */
    public static native int nativeSaveState(byte[] out);

    /** Restores a snapshot from {@code in}. */
    public static native boolean nativeLoadState(byte[] in, int length);
}

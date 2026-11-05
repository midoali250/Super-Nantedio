package com.midoali.snes;

/** Thin JNI bridge to the embedded Snes9x (libretro) core. */
public final class SnesCore {
    public static final int CHEAT_INF_HEALTH     = 1 << 0;
    public static final int CHEAT_INF_MASK_POWER = 1 << 1;
    public static final int CHEAT_INF_LIVES      = 1 << 2;
    public static final int CHEAT_INVINCIBLE     = 1 << 3;
    public static final int CHEAT_MOON_JUMP      = 1 << 4;
    public static final int CHEAT_LEVEL_SELECT   = 1 << 5;
    public static final int CHEAT_ALL            = 0x3F;

    static {
        System.loadLibrary("snescore");
    }

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

    /** Sets the active built-in cheat bitmask for The Mask (USA). */
    public static native void nativeSetCheats(int cheatMask);

    /** Returns the active built-in cheat bitmask. */
    public static native int nativeGetCheats();

    /** Applies a raw Game Genie (XXXX-XXXX) or Pro Action Replay (7EXXXXYY) code. */
    public static native void nativeApplyCheatCode(int index, boolean enabled, String code);

    /** Drains queued stereo frames into {@code out}; returns frames written. */
    public static native int nativeReadAudio(short[] out, int maxFrames);

    public static native double nativeFps();

    public static native double nativeSampleRate();
}

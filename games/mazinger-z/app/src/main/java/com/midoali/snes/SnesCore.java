package com.midoali.snes;

/** Thin JNI bridge to the embedded Snes9x (libretro) core. */
public final class SnesCore {
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

    /** Drains queued stereo frames into {@code out}; returns frames written. */
    public static native int nativeReadAudio(short[] out, int maxFrames);

    public static native double nativeFps();

    public static native double nativeSampleRate();
}

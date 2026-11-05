package com.midoali.nes;

/** Thin JNI bridge to the embedded FCEUmm (libretro) core. */
public final class NesCore {
    static {
        System.loadLibrary("nescore");
    }

    private NesCore() { }

    /** Boots the ROM held in {@code rom}; {@code saveDir} is the app files dir. */
    public static native boolean nativeStart(byte[] rom, String saveDir);

    /** Runs exactly one video frame of the emulated console. */
    public static native void nativeRunFrame();

    public static native void nativeInfiniteLives();

    public static native void nativeMarioProtection(int flags);

    public static native int nativeFrameWidth();

    public static native int nativeFrameHeight();

    /** Copies the latest RGB565 frame into a direct buffer; 1 on success. */
    public static native int nativeCopyVideo(java.nio.ByteBuffer buffer);

    /** Joypad bitmask (libretro ids) + Zapper position and trigger. */
    public static native void nativeSetInput(int mask, int gunX, int gunY, int trigger);

    /** Drains queued stereo frames into {@code out}; returns frames written. */
    public static native int nativeReadAudio(short[] out, int maxFrames);

    public static native double nativeFps();

    public static native double nativeSampleRate();
}

package com.midoali.snes;

import java.nio.ByteBuffer;

/** JNI bridge to libretro Genesis Plus GX (Sunset Riders / رعاة البقر). */
final class SnesCore {
    static {
        System.loadLibrary("snescore");
    }

    static final int CHEAT_INF_LIVES     = 1 << 0;
    static final int CHEAT_INVINCIBLE    = 1 << 1;
    static final int CHEAT_MAX_FIREPOWER = 1 << 2;
    static final int CHEAT_INF_CREDITS   = 1 << 3;
    static final int CHEAT_ONE_HIT_BOSS  = 1 << 4;
    static final int CHEAT_INF_LIVES_P2  = 1 << 5;
    static final int CHEAT_ALL           = 0x3F;

    static final int VIDEO_FILTER_HD_CRISP  = 0;
    static final int VIDEO_FILTER_SMOOTH    = 1;
    static final int VIDEO_FILTER_RAW_PIXEL = 2;

    static native boolean nativeStart(byte[] rom, String saveDir);
    static native void    nativeStop();
    static native void    nativeRunFrame();
    static native int     nativeFrameWidth();
    static native int     nativeFrameHeight();
    static native int     nativeCopyVideo(ByteBuffer dstRgb565);
    static native void    nativeSetInput(int mask);
    static native void    nativeSetCheats(int mask);
    static native int     nativeGetCheats();
    static native void    nativeSetVideoFilter(int mode);
    static native int     nativeGetVideoFilter();
    static native void    nativeApplyCheatCode(int index, boolean enabled, String code);
    static native int     nativeReadAudio(short[] outStereoPcm, int maxFrames);
    static native double  nativeFps();
    static native double  nativeSampleRate();

    private SnesCore() {}
}

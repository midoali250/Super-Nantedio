package com.midoali.nes;

/** Maps NES pixel coordinates onto FCEUmm's signed light-gun axis range. */
final class Zapper {
    private Zapper() { }

    /** NES pixel column -> signed RETRO_DEVICE_ID_LIGHTGUN_SCREEN_X. */
    static int gunX(int px) {
        int v = Math.round(px * 65532f / 256f) - 32766;
        return Math.max(-32768, Math.min(32767, v));
    }

    /** NES pixel row -> signed RETRO_DEVICE_ID_LIGHTGUN_SCREEN_Y. */
    static int gunY(int py) {
        int v = Math.round(py * 65536f / 240f) - 32768;
        return Math.max(-32768, Math.min(32767, v));
    }
}

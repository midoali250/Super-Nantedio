package com.midoali.nes;

/**
 * Geometry shared by the video surface and the touch layer: where the NES
 * picture sits on screen, and which NES pixel a finger press means.
 *
 * Kept free of Android imports so it can be exercised on the host JVM.
 */
final class ScreenMap {
    static final int NES_WIDTH = 256, NES_HEIGHT = 240;
    private static final double NES_ASPECT = 4.0 / 3.0;   /* NES pixels are 8:7 */

    private ScreenMap() { }

    /** Fits the picture into the view (letterboxed, never cropped): {l, t, w, h}. */
    static int[] fitRect(int viewW, int viewH) {
        if (viewW <= 0 || viewH <= 0) return new int[] {0, 0, 0, 0};
        int w = viewW;
        int h = (int) Math.round(w / NES_ASPECT);
        if (h > viewH) {
            h = viewH;
            w = (int) Math.round(h * NES_ASPECT);
        }
        return new int[] {(viewW - w) / 2, (viewH - h) / 2, w, h};
    }

    static int nesX(float screenX, int left, int width) {
        if (width <= 0) return NES_WIDTH / 2;
        int v = Math.round((screenX - left) * NES_WIDTH / width);
        return Math.max(0, Math.min(NES_WIDTH - 1, v));
    }

    static int nesY(float screenY, int top, int height) {
        if (height <= 0) return NES_HEIGHT / 2;
        int v = Math.round((screenY - top) * NES_HEIGHT / height);
        return Math.max(0, Math.min(NES_HEIGHT - 1, v));
    }
}

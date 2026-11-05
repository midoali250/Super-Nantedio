package com.midoali.snes;

/**
 * Geometry shared by the video surface and the touch layer: where the SNES
 * picture sits on screen, and which SNES pixel a finger press means.
 *
 * Kept free of Android imports so it can be exercised on the host JVM.
 */
final class ScreenMap {
    static final int SNES_WIDTH = 256, SNES_HEIGHT = 224;
    private static final double SNES_ASPECT = 4.0 / 3.0;   /* SNES pixels are 8:7 */

    private ScreenMap() { }

    /** Fits the picture into the view (letterboxed, never cropped): {l, t, w, h}. */
    static int[] fitRect(int viewW, int viewH) {
        if (viewW <= 0 || viewH <= 0) return new int[] {0, 0, 0, 0};
        int w = viewW;
        int h = (int) Math.round(w / SNES_ASPECT);
        if (h > viewH) {
            h = viewH;
            w = (int) Math.round(h * SNES_ASPECT);
        }
        return new int[] {(viewW - w) / 2, (viewH - h) / 2, w, h};
    }

    static int snesX(float screenX, int left, int width) {
        if (width <= 0) return SNES_WIDTH / 2;
        int v = Math.round((screenX - left) * SNES_WIDTH / width);
        return Math.max(0, Math.min(SNES_WIDTH - 1, v));
    }

    static int snesY(float screenY, int top, int height) {
        if (height <= 0) return SNES_HEIGHT / 2;
        int v = Math.round((screenY - top) * SNES_HEIGHT / height);
        return Math.max(0, Math.min(SNES_HEIGHT - 1, v));
    }
}

package com.midoali.snes;

import java.util.Locale;

/**
 * Turns the on-screen controls and any physical gamepad into a SNES joypad
 * bitmask.
 *
 * Only the buttons this game actually reads are wired. Mazinger Z (Bandai 1993)
 * runs on a standard Super Famicom pad, so the full set is:
 *
 *     4 face buttons  B  Y  A  X
 *     2 shoulders     L  R
 *     4 directions    UP DOWN LEFT RIGHT
 *     2 system        START  SELECT
 *     = 12 inputs, all of them live
 *
 * Each input has its own on-screen slot, its own label and its own position, so
 * the settings panel can remap what a button *does* and where it *sits*.
 *
 * Button ids are the libretro RETRO_DEVICE_ID_JOYPAD_* values, so the mask can
 * be handed to the core unchanged.
 */
final class VirtualPad {
    /* libretro RETRO_DEVICE_ID_JOYPAD_* ids */
    static final int BTN_B = 0, BTN_Y = 1, BTN_SELECT = 2, BTN_START = 3,
            BTN_UP = 4, BTN_DOWN = 5, BTN_LEFT = 6, BTN_RIGHT = 7,
            BTN_A = 8, BTN_X = 9, BTN_L = 10, BTN_R = 11;

    static final int BTN_COUNT = 12;

    /* Action slots in the order the on-screen buttons are drawn/named. */
    static final int SLOT_B = 0, SLOT_Y = 1, SLOT_A = 2, SLOT_X = 3,
            SLOT_L = 4, SLOT_R = 5, SLOT_START = 6, SLOT_SELECT = 7;

    static final int SLOT_COUNT = 8;

    static final String[] SLOT_LABELS = {"B", "Y", "A", "X", "L", "R", "START", "SELECT"};

    /* libretro id each slot sends by default (identity mapping). */
    private static final int[] DEFAULT_TARGET = {
            BTN_B, BTN_Y, BTN_A, BTN_X, BTN_L, BTN_R, BTN_START, BTN_SELECT
    };

    /*
     * NO DEADZONE, NO CLAMP.
     *
     * The stick follows the finger 1:1. The previous build scaled the input by a
     * radius and dropped everything inside a 22% dead circle, which made the
     * first few pixels of travel do nothing and made the pad feel stiff. Here
     * any non-zero displacement presses the matching direction immediately, and
     * horizontal/vertical runs are resolved by comparing the raw components, so
     * diagonals stay available at any angle.
     */
    static final float STICK_DEADZONE = 0.0f;

    private final boolean[] held = new boolean[BTN_COUNT];
    private final int[] target = DEFAULT_TARGET.clone();
    private int mask;

    /* Live stick read-out, for the settings preview. */
    private float stickNormX;
    private float stickNormY;

    VirtualPad() {
    }

    synchronized void setButton(int libretroId, boolean down) {
        if (libretroId < 0 || libretroId >= BTN_COUNT) return;
        held[libretroId] = down;
        rebuild();
    }

    /** Which libretro id a slot currently sends. */
    synchronized int targetOf(int slot) {
        if (slot < 0 || slot >= SLOT_COUNT) return -1;
        return target[slot];
    }

    /** Remaps a slot; returns false when the target is already used elsewhere. */
    synchronized boolean remap(int slot, int libretroId) {
        if (slot < 0 || slot >= SLOT_COUNT) return false;
        if (libretroId < 0 || libretroId >= BTN_COUNT) return false;
        for (int i = 0; i < SLOT_COUNT; i++) {
            if (i != slot && target[i] == libretroId) return false;
        }
        target[slot] = libretroId;
        rebuild();
        return true;
    }

    synchronized void resetMapping() {
        System.arraycopy(DEFAULT_TARGET, 0, target, 0, SLOT_COUNT);
        rebuild();
    }

    /** Press/release a slot by the action it represents (already remapped). */
    synchronized void setSlot(int slot, boolean down) {
        if (slot < 0 || slot >= SLOT_COUNT) return;
        setButton(target[slot], down);
    }

    synchronized String slotTargetName(int slot) {
        return nameOf(targetOf(slot));
    }

    static String nameOf(int libretroId) {
        switch (libretroId) {
            case BTN_B: return "B";
            case BTN_Y: return "Y";
            case BTN_SELECT: return "SELECT";
            case BTN_START: return "START";
            case BTN_UP: return "UP";
            case BTN_DOWN: return "DOWN";
            case BTN_LEFT: return "LEFT";
            case BTN_RIGHT: return "RIGHT";
            case BTN_A: return "A";
            case BTN_X: return "X";
            case BTN_L: return "L";
            case BTN_R: return "R";
            default: return "?";
        }
    }

    synchronized void setDpad(boolean up, boolean down, boolean left, boolean right) {
        boolean changed = held[BTN_UP] != up || held[BTN_DOWN] != down
                || held[BTN_LEFT] != left || held[BTN_RIGHT] != right;
        held[BTN_UP] = up;
        held[BTN_DOWN] = down;
        held[BTN_LEFT] = left;
        held[BTN_RIGHT] = right;
        if (changed) rebuild();
    }

    /**
     * Unlimited analog stick.
     *
     * Returns {baseX, baseY, knobX, knobY}. The knob tracks the thumb exactly,
     * the base is dragged along so the stick never runs out of travel, and the
     * D-pad is derived from the raw displacement without a dead circle.
     */
    synchronized float[] updateFreeStick(float baseX, float baseY,
                                         float touchX, float touchY,
                                         float maxRadius, boolean freeFollow) {
        float dx = touchX - baseX;
        float dy = touchY - baseY;

        /* No limit: the knob sits under the finger, the base follows behind it
         * once the thumb leaves the ring, so travel is never clamped. */
        float knobX = touchX;
        float knobY = touchY;
        if (freeFollow) {
            float dist = (float) Math.sqrt(dx * dx + dy * dy);
            if (maxRadius > 0f && dist > maxRadius) {
                float ux = dx / dist;
                float uy = dy / dist;
                baseX = touchX - ux * maxRadius;
                baseY = touchY - uy * maxRadius;
                dx = knobX - baseX;
                dy = knobY - baseY;
            }
        }

        if (maxRadius <= 0f) maxRadius = 1f;
        stickNormX = Math.max(-1f, Math.min(1f, dx / maxRadius));
        stickNormY = Math.max(-1f, Math.min(1f, dy / maxRadius));

        /* Direction from the raw components: no dead zone, and diagonals are
         * kept whenever the smaller axis clears ~40% of the larger one. */
        boolean up = false, down = false, left = false, right = false;
        if (dx != 0f || dy != 0f) {
            float ax = Math.abs(dx), ay = Math.abs(dy);
            float major = Math.max(ax, ay);
            right = dx > 0f && ax >= major * 0.4f;
            left = dx < 0f && ax >= major * 0.4f;
            down = dy > 0f && ay >= major * 0.4f;
            up = dy < 0f && ay >= major * 0.4f;
            if (!up && !down && !left && !right) {
                /* Perfectly shaped push on one axis only. */
                if (ax > ay) { right = dx > 0f; left = dx < 0f; }
                else { down = dy > 0f; up = dy < 0f; }
            }
        }
        setDpad(up, down, left, right);
        return new float[] {baseX, baseY, knobX, knobY};
    }

    synchronized float stickNormX() { return stickNormX; }

    synchronized float stickNormY() { return stickNormY; }

    synchronized void releaseAll() {
        for (int i = 0; i < BTN_COUNT; i++) held[i] = false;
        stickNormX = 0f;
        stickNormY = 0f;
        rebuild();
    }

    private void rebuild() {
        int m = 0;
        for (int i = 0; i < BTN_COUNT; i++) {
            if (held[i]) m |= 1 << i;
        }
        mask = m;
    }

    synchronized int mask() {
        return mask;
    }

    /** Human readable dump of the mask, used by the tests and the About panel. */
    synchronized String maskNames() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < BTN_COUNT; i++) {
            if (held[i]) {
                if (sb.length() > 0) sb.append('+');
                sb.append(nameOf(i));
            }
        }
        return sb.length() == 0 ? "-" : sb.toString();
    }

    synchronized String mappingSummary() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < SLOT_COUNT; i++) {
            if (sb.length() > 0) sb.append(' ');
            sb.append(String.format(Locale.US, "%s:%s", SLOT_LABELS[i], nameOf(target[i])));
        }
        return sb.toString();
    }
}

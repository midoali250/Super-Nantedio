package com.midoali.snes;

/**
 * Turns the on-screen controls into a SNES joypad bitmask.
 *
 * The SNES pad has four face buttons in a diamond (X on top, Y left, A right,
 * B bottom) plus L and R shoulders, a D-pad and START / SELECT.
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

    /* Face-button slots in the order the on-screen diamond draws them. */
    static final int FACE_A = 0, FACE_B = 1, FACE_X = 2, FACE_Y = 3;
    static final int SHOULDER_L = 0, SHOULDER_R = 1;

    private final boolean[] held = new boolean[BTN_COUNT];
    private int mask;

    VirtualPad() {
    }

    synchronized void setButton(int libretroId, boolean down) {
        if (libretroId < 0 || libretroId >= BTN_COUNT) return;
        held[libretroId] = down;
        rebuild();
    }

    /** Convenience wrappers so the view does not need to know libretro ids. */
    synchronized void setFace(int faceSlot, boolean down) {
        switch (faceSlot) {
            case FACE_A: setButton(BTN_A, down); break;
            case FACE_B: setButton(BTN_B, down); break;
            case FACE_X: setButton(BTN_X, down); break;
            case FACE_Y: setButton(BTN_Y, down); break;
            default: break;
        }
    }

    synchronized void setShoulder(int shoulderSlot, boolean down) {
        if (shoulderSlot == SHOULDER_L) setButton(BTN_L, down);
        else if (shoulderSlot == SHOULDER_R) setButton(BTN_R, down);
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

    synchronized void releaseAll() {
        for (int i = 0; i < BTN_COUNT; i++) held[i] = false;
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
}

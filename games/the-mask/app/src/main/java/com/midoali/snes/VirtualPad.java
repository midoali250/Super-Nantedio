package com.midoali.snes;

/**
 * Turns the on-screen controls (including the 360-degree free-floating virtual
 * analog joystick) into a SNES joypad bitmask.
 *
 * The SNES pad has four face buttons in a diamond (X on top, Y left, A right,
 * B bottom) plus L and R shoulders, a directional stick and START / SELECT.
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

    /* Deadzone as a fraction of stick radius. */
    static final float STICK_DEADZONE = 0.22f;

    private final boolean[] held = new boolean[BTN_COUNT];
    private int mask;
    private float stickNormX;
    private float stickNormY;

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
        if (!up && !down && !left && !right) {
            stickNormX = 0f;
            stickNormY = 0f;
        }
        if (changed) rebuild();
    }

    /**
     * Updates the virtual analog stick from a touch displacement (dx, dy)
     * relative to the stick base and returns the updated {baseX, baseY, knobX, knobY}.
     * When {@code freeFollow} is true and the finger drags past {@code maxRadius},
     * the floating base smoothly follows behind the thumb.
     */
    synchronized float[] updateFreeStick(float baseX, float baseY,
                                         float touchX, float touchY,
                                         float maxRadius, boolean freeFollow) {
        if (maxRadius <= 1f) maxRadius = 1f;
        float dx = touchX - baseX;
        float dy = touchY - baseY;
        float dist = (float) Math.hypot(dx, dy);
        float knobX = touchX;
        float knobY = touchY;

        if (dist > maxRadius) {
            float ux = dx / dist;
            float uy = dy / dist;
            if (freeFollow) {
                baseX = touchX - ux * maxRadius;
                baseY = touchY - uy * maxRadius;
                knobX = touchX;
                knobY = touchY;
            } else {
                knobX = baseX + ux * maxRadius;
                knobY = baseY + uy * maxRadius;
            }
            dx = knobX - baseX;
            dy = knobY - baseY;
            dist = maxRadius;
        }

        stickNormX = Math.max(-1f, Math.min(1f, dx / maxRadius));
        stickNormY = Math.max(-1f, Math.min(1f, dy / maxRadius));

        boolean up = false, down = false, left = false, right = false;
        if (dist / maxRadius >= STICK_DEADZONE) {
            double deg = Math.toDegrees(Math.atan2(dy, dx));
            right = deg > -67.5 && deg < 67.5;
            left = deg > 112.5 || deg < -112.5;
            down = deg >= 22.5 && deg <= 157.5;
            up = deg <= -22.5 && deg >= -157.5;
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
}

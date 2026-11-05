package com.midoali.nes;

/**
 * Turns the on-screen controls into a NES joypad bitmask plus a Zapper
 * position/trigger for the light-gun games.
 *
 * Button layout (right hand side, 4 buttons):
 *   BIG JUMP     - one press performs a full-height jump (A held ~32 frames)
 *   SMALL JUMP   - repeat: while held, short hops are produced over and over
 *   FIRE (auto)  - while held, the B button is pulsed (rapid fireballs)
 *   FIRE (once)  - one press fires exactly one fireball
 *
 * The left stick is free/analog and maps to the 8 pad directions.
 */
final class VirtualPad {
    /* libretro RETRO_DEVICE_ID_JOYPAD_* ids */
    static final int BTN_B = 0, BTN_Y = 1, BTN_SELECT = 2, BTN_START = 3,
            BTN_UP = 4, BTN_DOWN = 5, BTN_LEFT = 6, BTN_RIGHT = 7, BTN_A = 8;

    static final int BTN_BIG_JUMP = 0, BTN_SMALL_JUMP = 1, BTN_FIRE_AUTO = 2, BTN_FIRE_ONCE = 3;

    private static final float DEADZONE = 0.16f;
    private static final int BIG_JUMP_FRAMES = 32;
    private static final int SMALL_JUMP_ON = 4, SMALL_JUMP_PERIOD = 16;
    private static final int FIRE_AUTO_ON = 4, FIRE_AUTO_PERIOD = 9;
    private static final int FIRE_ONCE_FRAMES = 4;
    private static final int GUN_TRIGGER_FRAMES = 8;

    private float stickX, stickY;

    private final boolean[] held = new boolean[4];
    private boolean startHeld, selectHeld;

    /* per-frame state machines */
    private int bigJumpFrames;
    private int smallJumpPhase = -1;
    private int fireAutoPhase = -1;
    private int fireOnceFrames;

    private int gunX, gunY, gunFrames;

    private int mask;

    synchronized void setStick(float x, float y) {
        stickX = x;
        stickY = y;
    }

    synchronized void setButton(int which, boolean down) {
        if (which < 0 || which >= held.length) return;
        if (down && !held[which]) {
            if (which == BTN_BIG_JUMP) bigJumpFrames = BIG_JUMP_FRAMES;
            if (which == BTN_SMALL_JUMP) smallJumpPhase = 0;
            if (which == BTN_FIRE_AUTO) fireAutoPhase = 0;
            if (which == BTN_FIRE_ONCE) fireOnceFrames = FIRE_ONCE_FRAMES;
        }
        if (!down) {
            if (which == BTN_SMALL_JUMP) smallJumpPhase = -1;
            if (which == BTN_FIRE_AUTO) fireAutoPhase = -1;
        }
        held[which] = down;
    }

    synchronized void setStart(boolean down) { startHeld = down; }

    synchronized void setSelect(boolean down) { selectHeld = down; }

    /** Moves the light gun without pulling the trigger. */
    synchronized void aim(int x, int y) {
        gunX = x;
        gunY = y;
    }

    /** Light-gun shot at NES pixel (x, y). */
    synchronized void shoot(int x, int y) {
        gunX = x;
        gunY = y;
        gunFrames = GUN_TRIGGER_FRAMES;
    }

    /** Advances the state machines by one frame and rebuilds the bitmask. */
    synchronized void beginFrame() {
        int m = 0;

        float ax = Math.abs(stickX), ay = Math.abs(stickY);
        if (ax > DEADZONE || ay > DEADZONE) {
            double angle = Math.atan2(stickY, stickX);           /* y down = +pi/2 */
            double deg = Math.toDegrees(angle);
            boolean right = deg > -67.5 && deg < 67.5;
            boolean left = deg > 112.5 || deg < -112.5;
            boolean down = deg >= 22.5 && deg <= 157.5;
            boolean up = deg <= -22.5 && deg >= -157.5;
            if (right) m |= 1 << BTN_RIGHT;
            if (left) m |= 1 << BTN_LEFT;
            if (down) m |= 1 << BTN_DOWN;
            if (up) m |= 1 << BTN_UP;
        }

        if (startHeld) m |= 1 << BTN_START;
        if (selectHeld) m |= 1 << BTN_SELECT;

        /* big jump: committed full-height jump */
        if (bigJumpFrames > 0) {
            m |= 1 << BTN_A;
            bigJumpFrames--;
        }

        /* small jump: repeated short hops while held */
        if (smallJumpPhase >= 0) {
            if (smallJumpPhase % SMALL_JUMP_PERIOD < SMALL_JUMP_ON) m |= 1 << BTN_A;
            smallJumpPhase++;
        }

        /* fireball, rapid fire while held */
        if (fireAutoPhase >= 0) {
            if (fireAutoPhase % FIRE_AUTO_PERIOD < FIRE_AUTO_ON) m |= 1 << BTN_B;
            fireAutoPhase++;
        }

        /* fireball, single shot per press */
        if (fireOnceFrames > 0) {
            m |= 1 << BTN_B;
            fireOnceFrames--;
        }

        mask = m;
    }

    synchronized int mask() { return mask; }

    synchronized int gunX() { return gunX; }

    synchronized int gunY() { return gunY; }

    synchronized int gunTrigger() { return gunFrames > 0 ? 1 : 0; }

    /** Called once per emulated frame, after the frame has been run. */
    synchronized void endFrame() {
        if (gunFrames > 0) gunFrames--;
    }
}

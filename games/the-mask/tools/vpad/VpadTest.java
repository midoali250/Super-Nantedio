package com.midoali.snes;

/**
 * Host-side test for the control layer. VirtualPad and ScreenMap have no
 * Android imports on purpose, so the exact classes that ship inside the APK
 * can be compiled and driven here.
 */
public final class VpadTest {
    private static int failures;

    private static void check(String what, boolean ok) {
        if (!ok) failures++;
        System.out.println((ok ? "  ok   " : "  FAIL ") + what);
    }

    public static void main(String[] args) {
        dpad();
        freeJoystick();
        faceButtons();
        shoulders();
        startSelect();
        releaseAll();
        screenMap();
        System.out.println(failures == 0 ? "ALL TESTS PASSED" : failures + " TEST(S) FAILED");
        if (failures != 0) System.exit(1);
    }

    private static void dpad() {
        System.out.println("d-pad");
        VirtualPad p = new VirtualPad();
        p.setDpad(false, false, false, true);
        check("right -> RIGHT", (p.mask() & (1 << VirtualPad.BTN_RIGHT)) != 0);
        p.setDpad(false, false, true, false);
        check("left -> LEFT", (p.mask() & (1 << VirtualPad.BTN_LEFT)) != 0);
        p.setDpad(true, false, false, false);
        check("up -> UP", (p.mask() & (1 << VirtualPad.BTN_UP)) != 0);
        p.setDpad(false, true, false, false);
        check("down -> DOWN", (p.mask() & (1 << VirtualPad.BTN_DOWN)) != 0);

        p.setDpad(true, false, false, true);
        int m = p.mask();
        check("diagonal up-right -> UP+RIGHT",
                (m & (1 << VirtualPad.BTN_UP)) != 0 && (m & (1 << VirtualPad.BTN_RIGHT)) != 0);

        p.setDpad(false, false, false, false);
        check("centre releases every direction", (p.mask() & 0x03F0) == 0);
    }

    private static void freeJoystick() {
        System.out.println("free-floating joystick");
        VirtualPad p = new VirtualPad();
        float[] r = p.updateFreeStick(200f, 500f, 205f, 503f, 100f, true);
        check("small touch inside deadzone keeps stick neutral", (p.mask() & 0x03F0) == 0);

        r = p.updateFreeStick(200f, 500f, 350f, 500f, 100f, true);
        check("dragging right engages RIGHT", (p.mask() & (1 << VirtualPad.BTN_RIGHT)) != 0);
        check("free-floating base follows thumb when dragged past radius",
                Math.abs(r[0] - 250f) < 0.5f && Math.abs(r[2] - 350f) < 0.5f);
        check("stickNormX is +1.0 at full right deflection", Math.abs(p.stickNormX() - 1f) < 0.01f);

        p.updateFreeStick(200f, 500f, 120f, 420f, 100f, true);
        int m = p.mask();
        check("dragging up-left engages UP+LEFT",
                (m & (1 << VirtualPad.BTN_UP)) != 0 && (m & (1 << VirtualPad.BTN_LEFT)) != 0);
    }

    private static void faceButtons() {
        System.out.println("face buttons");
        VirtualPad p = new VirtualPad();
        p.setFace(VirtualPad.FACE_A, true);
        check("A -> A", (p.mask() & (1 << VirtualPad.BTN_A)) != 0);
        p.setFace(VirtualPad.FACE_B, true);
        check("B -> B", (p.mask() & (1 << VirtualPad.BTN_B)) != 0);
        p.setFace(VirtualPad.FACE_X, true);
        check("X -> X", (p.mask() & (1 << VirtualPad.BTN_X)) != 0);
        p.setFace(VirtualPad.FACE_Y, true);
        check("Y -> Y", (p.mask() & (1 << VirtualPad.BTN_Y)) != 0);
        p.setFace(VirtualPad.FACE_A, false);
        p.setFace(VirtualPad.FACE_B, false);
        p.setFace(VirtualPad.FACE_X, false);
        p.setFace(VirtualPad.FACE_Y, false);
        check("all face buttons released",
                (p.mask() & ((1 << VirtualPad.BTN_A) | (1 << VirtualPad.BTN_B)
                        | (1 << VirtualPad.BTN_X) | (1 << VirtualPad.BTN_Y))) == 0);
    }

    private static void shoulders() {
        System.out.println("shoulders");
        VirtualPad p = new VirtualPad();
        p.setShoulder(VirtualPad.SHOULDER_L, true);
        check("L -> L", (p.mask() & (1 << VirtualPad.BTN_L)) != 0);
        p.setShoulder(VirtualPad.SHOULDER_R, true);
        check("R -> R", (p.mask() & (1 << VirtualPad.BTN_R)) != 0);
        p.setShoulder(VirtualPad.SHOULDER_L, false);
        p.setShoulder(VirtualPad.SHOULDER_R, false);
        check("shoulders released",
                (p.mask() & ((1 << VirtualPad.BTN_L) | (1 << VirtualPad.BTN_R))) == 0);
    }

    private static void startSelect() {
        System.out.println("start / select");
        VirtualPad p = new VirtualPad();
        p.setButton(VirtualPad.BTN_START, true);
        check("START held", (p.mask() & (1 << VirtualPad.BTN_START)) != 0);
        p.setButton(VirtualPad.BTN_SELECT, true);
        check("SELECT held", (p.mask() & (1 << VirtualPad.BTN_SELECT)) != 0);
        p.setButton(VirtualPad.BTN_START, false);
        p.setButton(VirtualPad.BTN_SELECT, false);
        check("both released",
                (p.mask() & ((1 << VirtualPad.BTN_START) | (1 << VirtualPad.BTN_SELECT))) == 0);
    }

    private static void releaseAll() {
        System.out.println("release all");
        VirtualPad p = new VirtualPad();
        p.setDpad(true, true, true, true);
        p.setFace(VirtualPad.FACE_A, true);
        p.setFace(VirtualPad.FACE_B, true);
        p.setShoulder(VirtualPad.SHOULDER_L, true);
        p.setShoulder(VirtualPad.SHOULDER_R, true);
        p.setButton(VirtualPad.BTN_START, true);
        p.releaseAll();
        check("nothing stays pressed", p.mask() == 0);
    }

    private static void screenMap() {
        System.out.println("screen mapping");
        int[] full = ScreenMap.displayRect(2400, 1080, true);
        check("widescreen mobile mode fills full display width (2400x1080 at 0,0)",
                full[0] == 0 && full[1] == 0 && full[2] == 2400 && full[3] == 1080);

        int[] wide = ScreenMap.fitRect(1920, 1080);
        check("1920x1080 -> 4:3 pillarboxed (" + wide[2] + "x" + wide[3] + " at " + wide[0] + ")",
                wide[2] == 1440 && wide[3] == 1080 && wide[0] == 240 && wide[1] == 0);
        int[] square = ScreenMap.fitRect(256, 224);
        check("256x224 view -> 256x192 centred (4:3, no crop)",
                square[2] == 256 && square[3] == 192 && square[1] == 16);
        check("centre tap -> SNES (128,112)",
                ScreenMap.snesX(960, wide[0], wide[2]) == 128
                        && ScreenMap.snesY(540, wide[1], wide[3]) == 112);
        check("top-left of picture -> (0,0)",
                ScreenMap.snesX(240, wide[0], wide[2]) == 0
                        && ScreenMap.snesY(0, wide[1], wide[3]) == 0);
        check("bottom-right of picture -> (255,223)",
                ScreenMap.snesX(1679, wide[0], wide[2]) == 255
                        && ScreenMap.snesY(1079, wide[1], wide[3]) == 223);
        check("taps in the pillar box clamp inside the screen",
                ScreenMap.snesX(10, wide[0], wide[2]) == 0
                        && ScreenMap.snesX(1900, wide[0], wide[2]) == 255);
    }
}

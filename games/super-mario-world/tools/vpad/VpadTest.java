package com.midoali.nes;

/**
 * Host-side test for the control layer. VirtualPad and Zapper have no Android
 * imports on purpose, so the exact classes that ship inside the APK can be
 * compiled and driven here.
 *
 * Output is one line per frame:  FRAME <n> MASK <bits> GUN <x> <y> <trig>
 */
public final class VpadTest {
    private static int failures;

    private static void check(String what, boolean ok) {
        if (!ok) failures++;
        System.out.println((ok ? "  ok   " : "  FAIL ") + what);
    }

    public static void main(String[] args) {
        directions();
        bigJump();
        smallJumpRepeat();
        fireAuto();
        fireOnce();
        startSelect();
        zapper();
        screenMap();
        System.out.println(failures == 0 ? "ALL TESTS PASSED" : failures + " TEST(S) FAILED");
        if (failures != 0) System.exit(1);
    }

    private static int frame(VirtualPad p) {
        p.beginFrame();
        int m = p.mask();
        p.endFrame();
        return m;
    }

    private static void directions() {
        System.out.println("directions");
        VirtualPad p = new VirtualPad();
        p.setStick(1f, 0f);
        check("stick right -> RIGHT", (frame(p) & (1 << VirtualPad.BTN_RIGHT)) != 0);
        p.setStick(-1f, 0f);
        check("stick left -> LEFT", (frame(p) & (1 << VirtualPad.BTN_LEFT)) != 0);
        p.setStick(0f, -1f);
        check("stick up -> UP", (frame(p) & (1 << VirtualPad.BTN_UP)) != 0);
        p.setStick(0f, 1f);
        check("stick down -> DOWN", (frame(p) & (1 << VirtualPad.BTN_DOWN)) != 0);
        p.setStick(0.7f, -0.7f);
        int m = frame(p);
        check("diagonal right-up -> RIGHT+UP",
                (m & (1 << VirtualPad.BTN_RIGHT)) != 0 && (m & (1 << VirtualPad.BTN_UP)) != 0);
        p.setStick(0.05f, 0.05f);
        check("inside deadzone -> no direction", (frame(p) & 0x3F0) == 0);
        p.setStick(0.18f, 0f);
        check("light stick movement responds", (frame(p) & (1 << VirtualPad.BTN_RIGHT)) != 0);
    }

    private static void bigJump() {
        System.out.println("big jump");
        VirtualPad p = new VirtualPad();
        p.setButton(VirtualPad.BTN_BIG_JUMP, true);
        int on = 0;
        for (int i = 0; i < 40; i++) if ((frame(p) & (1 << VirtualPad.BTN_A)) != 0) on++;
        check("single press holds A for a full-height jump (" + on + " frames)", on == 32);
        p.setButton(VirtualPad.BTN_BIG_JUMP, false);
        check("A released afterwards", (frame(p) & (1 << VirtualPad.BTN_A)) == 0);
    }

    private static void smallJumpRepeat() {
        System.out.println("small jump (repeat)");
        VirtualPad p = new VirtualPad();
        p.setButton(VirtualPad.BTN_SMALL_JUMP, true);
        int pulses = 0, prev = 0;
        boolean widthsOk = true;
        int run = 0;
        for (int i = 0; i < 96; i++) {
            int a = (frame(p) & (1 << VirtualPad.BTN_A)) != 0 ? 1 : 0;
            if (a == 1) run++;
            if (prev == 0 && a == 1) pulses++;
            if (prev == 1 && a == 0) widthsOk &= run <= VirtualPad.class.getDeclaredFields().length;
            prev = a;
        }
        check("repeats while held (" + pulses + " hops)", pulses >= 4);
        p.setButton(VirtualPad.BTN_SMALL_JUMP, false);
        int after = 0;
        for (int i = 0; i < 20; i++) if ((frame(p) & (1 << VirtualPad.BTN_A)) != 0) after++;
        check("stops when released", after == 0);
    }

    private static void fireAuto() {
        System.out.println("rapid fire");
        VirtualPad p = new VirtualPad();
        p.setButton(VirtualPad.BTN_FIRE_AUTO, true);
        int pulses = 0, prev = 0;
        for (int i = 0; i < 96; i++) {
            int b = (frame(p) & (1 << VirtualPad.BTN_B)) != 0 ? 1 : 0;
            if (prev == 0 && b == 1) pulses++;
            prev = b;
        }
        check("B pulses while held (" + pulses + " shots)", pulses >= 8);
    }

    private static void fireOnce() {
        System.out.println("single fire");
        VirtualPad p = new VirtualPad();
        p.setButton(VirtualPad.BTN_FIRE_ONCE, true);
        int pulses = 0, prev = 0, frames = 0;
        for (int i = 0; i < 60; i++) {
            int b = (frame(p) & (1 << VirtualPad.BTN_B)) != 0 ? 1 : 0;
            if (b == 1) frames++;
            if (prev == 0 && b == 1) pulses++;
            prev = b;
        }
        p.setButton(VirtualPad.BTN_FIRE_ONCE, false);
        for (int i = 0; i < 30; i++) if ((frame(p) & (1 << VirtualPad.BTN_B)) != 0) frames++;
        check("one press -> one short shot (" + pulses + " pulse, " + frames + " frames)", pulses == 1 && frames <= 6);
    }

    private static void startSelect() {
        System.out.println("start / select");
        VirtualPad p = new VirtualPad();
        p.setStart(true);
        check("START held", (frame(p) & (1 << VirtualPad.BTN_START)) != 0);
        p.setStart(false);
        check("START released", (frame(p) & (1 << VirtualPad.BTN_START)) == 0);
        p.setSelect(true);
        check("SELECT held", (frame(p) & (1 << VirtualPad.BTN_SELECT)) != 0);
        p.setSelect(false);
    }

    private static void screenMap() {
        System.out.println("screen mapping");
        int[] wide = ScreenMap.fitRect(1920, 1080);
        check("1920x1080 -> 4:3 pillarboxed (" + wide[2] + "x" + wide[3] + " at " + wide[0] + ")",
                wide[2] == 1440 && wide[3] == 1080 && wide[0] == 240 && wide[1] == 0);
        int[] tall = ScreenMap.fitRect(1080, 1920);
        check("1080x1920 -> letterboxed full width", tall[2] == 1080 && tall[1] == (1920 - 810) / 2);
        int[] square = ScreenMap.fitRect(256, 240);
        check("256x240 view -> 256x192 centred (4:3, no crop)",
                square[2] == 256 && square[3] == 192 && square[1] == 24);
        check("centre tap -> NES (128,120)",
                ScreenMap.nesX(960, wide[0], wide[2]) == 128
                        && ScreenMap.nesY(540, wide[1], wide[3]) == 120);
        check("top-left of picture -> (0,0)",
                ScreenMap.nesX(240, wide[0], wide[2]) == 0
                        && ScreenMap.nesY(0, wide[1], wide[3]) == 0);
        check("bottom-right of picture -> (255,239)",
                ScreenMap.nesX(1679, wide[0], wide[2]) == 255
                        && ScreenMap.nesY(1079, wide[1], wide[3]) == 239);
        check("taps in the pillar box clamp inside the screen",
                ScreenMap.nesX(10, wide[0], wide[2]) == 0
                        && ScreenMap.nesX(1900, wide[0], wide[2]) == 255);
    }

    private static void zapper() {
        System.out.println("zapper");
        VirtualPad p = new VirtualPad();
        p.shoot(128, 120);
        check("trigger down right after a tap", p.gunTrigger() == 1);
        p.beginFrame();
        int held = 0;
        for (int i = 0; i < 20; i++) {
            if (p.gunTrigger() == 1) held++;
            p.beginFrame();
            p.endFrame();
        }
        check("trigger auto-releases (" + held + " frames)", held >= 3 && held <= 10);

        check("gunX(0) maps to -32766", Zapper.gunX(0) <= -32700);
        check("gunX(128) is near centre", Math.abs(Zapper.gunX(128) + 60) < 800);
        check("gunX(255) near +32766", Zapper.gunX(255) >= 32000);
        check("gunY(0) maps to -32768", Zapper.gunY(0) <= -32700);
        check("gunY(120) is near centre", Math.abs(Zapper.gunY(120) + 32) < 800);
        check("gunY(239) near +32768", Zapper.gunY(239) >= 32000);

        VirtualPad aim = new VirtualPad();
        aim.aim(200, 50);
        check("aim() moves without pulling the trigger", aim.gunTrigger() == 0
                && aim.gunX() == 200 && aim.gunY() == 50);
    }
}

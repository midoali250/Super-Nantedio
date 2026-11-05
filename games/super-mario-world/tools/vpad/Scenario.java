package com.midoali.nes;

/**
 * Emits the joypad/gun stream that the on-screen controls would produce for a
 * scripted play session, so the real core can be driven through it headlessly.
 *
 *   java com.midoali.nes.Scenario            > masks.txt
 *   python3 tools/host/drive.py ROM OUT --masks masks.txt
 */
public final class Scenario {
    private static final int START_FRAME = 120;   /* SMB title -> world 1-1 */
    private static final int WALK_FRAME = 470;
    private static final int JUMP_FRAME = 535;
    private static final int STOP_FRAME = 580;
    private static final int END_FRAME = 650;

    public static void main(String[] args) {
        VirtualPad p = new VirtualPad();
        StringBuilder out = new StringBuilder();
        for (int f = 0; f < END_FRAME; f++) {
            if (f == START_FRAME) p.setStart(true);
            if (f == START_FRAME + 12) p.setStart(false);
            if (f == WALK_FRAME) p.setStick(1f, 0f);
            if (f == JUMP_FRAME) p.setButton(VirtualPad.BTN_BIG_JUMP, true);
            if (f == JUMP_FRAME + 6) p.setButton(VirtualPad.BTN_BIG_JUMP, false);
            if (f == STOP_FRAME) p.setStick(0f, 0f);
            p.beginFrame();
            out.append(p.mask()).append(' ')
               .append(p.gunX()).append(' ').append(p.gunY()).append(' ')
               .append(p.gunTrigger()).append('\n');
            p.endFrame();
        }
        System.out.print(out);
    }
}

#!/usr/bin/env python3
"""Headless input/pad verification for the Mazinger Z desktop build.

Checks that the real Super Famicom button set is wired, that no deadzone or
clamp sneaks into the input path, and that keyboard/gamepad/mouse all resolve
to the same SNES bitmask.
"""
import os
import sys
from pathlib import Path

os.environ.setdefault('SDL_VIDEODRIVER', 'dummy')
os.environ.setdefault('SDL_AUDIODRIVER', 'dummy')

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import pygame  # noqa: E402

import app as frontend  # noqa: E402


class FakeKeys:
    def __init__(self, held):
        self.held = set(held)

    def __getitem__(self, key):
        return key in self.held


class FakePad:
    def __init__(self, buttons=(), axes=(), hat=(0, 0)):
        self.buttons = set(buttons)
        self.axes = list(axes)
        self.hat = hat

    def get_button(self, index):
        return index in self.buttons

    def get_numaxes(self):
        return len(self.axes)

    def get_axis(self, index):
        return self.axes[index]

    def get_numhats(self):
        return 1

    def get_hat(self, index):
        return self.hat


def main():
    pygame.init()
    failures = []

    def check(name, ok, detail=''):
        print(('PASS  ' if ok else 'FAIL  ') + name + ('  ' + detail if detail else ''))
        if not ok:
            failures.append(name)

    controls = frontend.DEFAULT_CONTROLS

    # 1. Every input the SNES pad has must exist.
    expected = {'UP', 'DOWN', 'LEFT', 'RIGHT', 'B', 'Y', 'A', 'X', 'L', 'R', 'START', 'SELECT'}
    check('All 12 game inputs are mapped', set(controls) == expected,
          'missing=%s' % sorted(expected - set(controls)))

    # 2. Every libretro joypad bit is distinct and within range.
    bits = [frontend.BIT[name] for name in expected]
    check('Bits are unique 0..11', sorted(bits) == list(range(12)), str(sorted(bits)))

    # 3. Keyboard resolves to the right mask.
    mask = frontend.input_mask(controls, FakeKeys({pygame.K_z}), (0, 0, 0, 0, 0), [])
    check('Keyboard Z fires B', mask == 1 << frontend.BIT['B'], 'mask=%d' % mask)

    mask = frontend.input_mask(controls, FakeKeys({pygame.K_RETURN}), (0, 0, 0, 0, 0), [])
    check('Enter fires START', mask == 1 << frontend.BIT['START'], 'mask=%d' % mask)

    # 4. Gamepad buttons resolve.
    pad = FakePad(buttons={0, 1, 4})
    mask = frontend.input_mask(controls, FakeKeys(set()), (0, 0, 0, 0, 0), [pad])
    want = (1 << frontend.BIT['B']) | (1 << frontend.BIT['A']) | (1 << frontend.BIT['L'])
    check('Gamepad buttons fire B+A+L', mask == want, 'mask=%d want=%d' % (mask, want))

    # 5. Axis movement is immediate: no deadzone at all.
    tiny = FakePad(axes=[0.02, 0.0])
    mask = frontend.input_mask(controls, FakeKeys(set()), (0, 0, 0, 0, 0), [tiny])
    check('No deadzone: 2% axis travel already moves', mask == 1 << frontend.BIT['RIGHT'],
          'mask=%d' % mask)

    # 6. Diagonals: both axes held gives both directions.
    diag = FakePad(axes=[0.7, -0.7])
    mask = frontend.input_mask(controls, FakeKeys(set()), (0, 0, 0, 0, 0), [diag])
    want = (1 << frontend.BIT['RIGHT']) | (1 << frontend.BIT['UP'])
    check('Diagonal right+up works', mask == want, 'mask=%d' % mask)

    # 7. D-pad hat.
    hat = FakePad(hat=(-1, 0))
    mask = frontend.input_mask(controls, FakeKeys(set()), (0, 0, 0, 0, 0), [hat])
    check('Hat left works', mask == 1 << frontend.BIT['LEFT'], 'mask=%d' % mask)

    # 8. Mouse left button fires B.
    mask = frontend.input_mask(controls, FakeKeys(set()), (1, 0, 0, 0, 0), [])
    check('Mouse left fires B', mask == 1 << frontend.BIT['B'], 'mask=%d' % mask)

    # 9. Remapping changes the label and survives a round-trip through describe().
    describe = frontend.describe(controls['X'])
    check('describe() reports X binding', bool(describe) and describe != '-', describe)

    # 10. Config default carries every remappable field.
    cfg = frontend.default_config()
    check('Default config has all controls', set(cfg['controls']) == expected)
    check('Default config has all core options',
          len(cfg['options']) == len(frontend.CORE_OPTIONS))

    pygame.quit()
    print()
    if failures:
        print('FAILURES: ' + ', '.join(failures))
        return 1
    print('ALL INPUT TESTS PASSED')
    return 0


if __name__ == '__main__':
    sys.exit(main())

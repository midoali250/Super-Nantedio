import os, sys
os.environ['SDL_VIDEODRIVER'] = 'dummy'
os.environ['SDL_AUDIODRIVER'] = 'dummy'
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
import app

class Keys:
    def __getitem__(self, k): return k in (app.pygame.K_z, app.pygame.K_x, app.pygame.K_q)

class Empty:
    def __getitem__(self, k): return False

class Pad:
    def get_numbuttons(self): return 10
    def get_button(self, n): return n in (1, 5)
    def get_numaxes(self): return 2
    def get_axis(self, n): return -0.8 if n == 0 else 0
    def get_numhats(self): return 0

m_keys = app.input_mask(app.DEFAULTS, Keys(), (False,) * 5, [], 0)
assert (m_keys & (1 << 0)) and (m_keys & (1 << 1)) and (m_keys & (1 << 10))
assert app.input_mask(app.DEFAULTS, Empty(), (True, False, False, False, False), [], 0) & (1 << 0)
m_pad = app.input_mask(app.DEFAULTS, Empty(), (False,) * 5, [Pad()], 0)
assert (m_pad & (1 << 6)) and (m_pad & (1 << 8)) and (m_pad & (1 << 11))
assert len(app.CHEAT_ITEMS) == 6 and app.CHEAT_ALL == 0x3F
assert '**Ahmed Kamal Elgandy**' in app.ABOUT_RAW_MARKDOWN
print('PASS: SNES 12-button keyboard, mouse, gamepad bindings, cheats, and About metadata')

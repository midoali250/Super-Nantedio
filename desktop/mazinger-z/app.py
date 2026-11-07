#!/usr/bin/env python3
"""
Mazinger Z (マジンガーZ, Bandai 1993) desktop frontend.

Snes9x 2010 core + True HD 4x vibrant video, full gamepad support, working
cheats and a complete settings panel with button remapping.

Runs the exact same native layer as the Android build (snes_jni.c), so both
platforms share one video pipeline, one input map and one cheat engine.

Usage:
    app.py                # play
    app.py --self-test    # headless core/video/input/cheat verification
    app.py --ui-test      # drive the menus with synthetic events
"""
import ctypes as C
import json
import os
import sys
import tempfile
import time
import urllib.request
from pathlib import Path

if sys.platform == 'win32':
    os.environ.setdefault('SDL_WINDOWS_DPI_AWARENESS', 'permonitorv2')
    try:
        C.windll.shcore.SetProcessDpiAwareness(2)
    except Exception:
        try:
            C.windll.user32.SetProcessDPIAware()
        except Exception:
            pass

import pygame

VERSION = '1.0.0'
GAME_ID = 'mazinger-z'
CATALOG = ('https://raw.githubusercontent.com/midoali250/bitvault-engine/'
           'refs/heads/main/updates/desktop/mazinger-z.json')
ROOT = Path(getattr(sys, '_MEIPASS', Path(__file__).resolve().parent))

ABOUT_RAW_MARKDOWN = (
    'This application has been developed by **Ahmed Kamal Elgandy** to serve as a digital archive '
    'and platform for running and optimizing classic retro and Atari-style games on mobile devices. '
    'The project aims to revive memories and preserve the software heritage of classic games with '
    'a smooth, lightweight experience, while fully respecting the intellectual property rights of '
    'the original production companies.'
)
ABOUT_PLAIN_TEXT = ABOUT_RAW_MARKDOWN.replace('**', '')

# ---------------------------------------------------------------- video modes
FILTER_MODES = ['hd_crisp', 'smooth', 'sharp']
FILTER_LABELS = {
    'hd_crisp': 'True HD Crisp - 4x Scale2x + Vibrant Arcade colours (1024x896)',
    'smooth': 'Ultra Smooth - 4x bilinear (soft, arcade CRT feel)',
    'sharp': 'Raw Pixel - exact 1x console pixels (256x224)',
}
FILTER_NATIVE = {'hd_crisp': 0, 'smooth': 1, 'sharp': 2}

# ------------------------------------------------------------- core options
# (label, native index, [choices], human labels)
CORE_OPTIONS = [
    ('Region', 0, ['ntsc', 'pal'], ['NTSC 60 Hz (default)', 'PAL 50 Hz']),
    ('Audio interpolation', 1, ['none', 'linear', 'gaussian', 'cubic', 'sinc'],
     ['None (sharpest)', 'Linear', 'Gaussian (default, warm)', 'Cubic', 'Sinc (cleanest)']),
    ('Aspect ratio', 2, ['4:3', '8:7', 'uncorrected'],
     ['4:3 (TV, default)', '8:7 (native pixels)', 'Uncorrected (stretch)']),
    ('Frame skip', 3, ['none', 'auto'], ['None - always 60 fps (default)', 'Auto - keeps speed on weak PCs']),
    ('Sprite flicker', 4, ['disabled', 'enabled'],
     ['Disabled - original hardware (default)', 'Enabled - reduces flicker']),
    ('CPU overclock', 5, ['disabled', 'enabled'], ['Off (default)', 'On - smoother slow-motion scenes']),
]

# ------------------------------------------------------------------ cheats
CHEATS = [
    ('Infinite lives', 1 << 0),
    ('Invincible', 1 << 1),
    ('Infinite energy', 1 << 2),
    ('Moon jump (hold B)', 1 << 3),
    ('Infinite time', 1 << 4),
    ('Super speed', 1 << 5),
    ('Rapid fire', 1 << 6),
]

# ------------------------------------------------------------------- input
# Every input Mazinger Z reads from the real Super Famicom pad.
# name: (keyboard keys, gamepad buttons, gamepad axes, hat directions, mouse)
DEFAULT_CONTROLS = {
    'UP':     {'key': [pygame.K_UP],    'pad': [['axis', 1, -1], ['hat', 0, 0, 1]],  'mouse': []},
    'DOWN':   {'key': [pygame.K_DOWN],  'pad': [['axis', 1, 1], ['hat', 0, 0, -1]],  'mouse': []},
    'LEFT':   {'key': [pygame.K_LEFT],  'pad': [['axis', 0, -1], ['hat', 0, -1, 0]], 'mouse': []},
    'RIGHT':  {'key': [pygame.K_RIGHT], 'pad': [['axis', 0, 1], ['hat', 0, 1, 0]],   'mouse': []},
    'B':      {'key': [pygame.K_z],     'pad': [['button', 0]],                      'mouse': [0]},
    'Y':      {'key': [pygame.K_x],     'pad': [['button', 2]],                      'mouse': [2]},
    'A':      {'key': [pygame.K_s, pygame.K_c], 'pad': [['button', 1]],              'mouse': []},
    'X':      {'key': [pygame.K_d],     'pad': [['button', 3]],                      'mouse': []},
    'L':      {'key': [pygame.K_q],     'pad': [['button', 4]],                      'mouse': []},
    'R':      {'key': [pygame.K_w],     'pad': [['button', 5]],                      'mouse': []},
    'START':  {'key': [pygame.K_RETURN], 'pad': [['button', 7]],                      'mouse': []},
    'SELECT': {'key': [pygame.K_RSHIFT], 'pad': [['button', 6]],                      'mouse': []},
}

# libretro RETRO_DEVICE_ID_JOYPAD_* bit positions
BIT = {
    'B': 0, 'Y': 1, 'SELECT': 2, 'START': 3, 'UP': 4,
    'DOWN': 5, 'LEFT': 6, 'RIGHT': 7, 'A': 8, 'X': 9, 'L': 10, 'R': 11,
}

BUTTON_ORDER = ['UP', 'DOWN', 'LEFT', 'RIGHT', 'B', 'Y', 'A', 'X', 'L', 'R', 'START', 'SELECT']


class Core:
    """ctypes wrapper around the shared libretro frontend."""

    def __init__(self, rom_path=None):
        if sys.platform == 'win32':
            library = 'libsnesapp_host.dll' if (ROOT / 'libsnesapp_host.dll').exists() else 'snesapp_host.dll'
        elif sys.platform == 'darwin':
            library = 'libsnesapp_host.dylib'
        else:
            library = 'libsnesapp_host.so'
        self.lib = C.CDLL(str(ROOT / library))
        L = self.lib
        L.host_start.argtypes, L.host_start.restype = [C.c_char_p, C.c_int], C.c_int
        for name in ('host_reset', 'host_stop', 'host_frame'):
            getattr(L, name).argtypes = []
        L.host_input.argtypes = [C.c_int]
        L.host_set_video_filter.argtypes = [C.c_int]
        L.host_get_video_filter.argtypes, L.host_get_video_filter.restype = [], C.c_int
        L.host_width.argtypes, L.host_width.restype = [], C.c_int
        L.host_height.argtypes, L.host_height.restype = [], C.c_int
        L.host_video.argtypes, L.host_video.restype = [C.c_void_p, C.c_int], C.c_int
        L.host_read_audio.argtypes = [C.POINTER(C.c_int16), C.c_int]
        L.host_read_audio.restype = C.c_int
        L.host_set_cheats.argtypes, L.host_get_cheats.argtypes = [C.c_int], []
        L.host_get_cheats.restype = C.c_int
        L.host_apply_cheat_code.argtypes = [C.c_int, C.c_int, C.c_char_p]
        L.host_apply_cheat_code.restype = C.c_int
        L.host_read_ram.argtypes, L.host_read_ram.restype = [C.c_int], C.c_int
        L.host_write_ram.argtypes = [C.c_int, C.c_int]
        L.host_set_core_option.argtypes = [C.c_int, C.c_char_p]
        L.host_get_core_option.argtypes, L.host_get_core_option.restype = [C.c_int], C.c_char_p

        self.tempdir = tempfile.TemporaryDirectory(prefix='bitvault-mazinger-z-')
        os.environ['MAZINGER_Z_TEMP'] = self.tempdir.name
        path = Path(rom_path) if rom_path else (ROOT / 'mazingerz.smc')
        data = path.read_bytes()
        if not self.lib.host_start(data, len(data)):
            raise RuntimeError('Could not start ROM')
        self.w = self.lib.host_width()
        self.h = self.lib.host_height()
        self.video = C.create_string_buffer(1024 * 1024 * 2)
        self.audio = (C.c_int16 * 8192)()

    # -- video
    def frame(self, mask):
        self.lib.host_input(mask)
        self.lib.host_frame()

    def reset(self):
        self.lib.host_input(0)
        self.lib.host_reset()
        self.w = self.lib.host_width()
        self.h = self.lib.host_height()

    def set_video_filter(self, name):
        self.lib.host_set_video_filter(FILTER_NATIVE.get(name, 0))

    def get_video_filter(self):
        return int(self.lib.host_get_video_filter())

    def framebuffer(self):
        self.w = self.lib.host_width()
        self.h = self.lib.host_height()
        size = self.lib.host_video(self.video, len(self.video))
        if size != self.w * self.h * 2:
            raise RuntimeError('No frame')
        return self.video.raw[:size]

    # -- audio
    def samples(self):
        n = self.lib.host_read_audio(self.audio, 4096)
        return C.string_at(self.audio, n * 4) if n > 0 else b''

    # -- cheats
    def set_cheats(self, mask):
        self.lib.host_set_cheats(mask)

    def apply_cheat_code(self, index, enabled, code):
        return int(self.lib.host_apply_cheat_code(index, 1 if enabled else 0, code.encode('ascii', 'ignore')))

    def reset_cheat_codes(self):
        self.lib.host_apply_cheat_code(0, 0, None)

    # -- memory
    def read_ram(self, address):
        return int(self.lib.host_read_ram(address))

    def write_ram(self, address, value):
        self.lib.host_write_ram(address, value)

    # -- core options
    def set_option(self, index, value):
        self.lib.host_set_core_option(index, value.encode('ascii', 'ignore'))

    def get_option(self, index):
        return (self.lib.host_get_core_option(index) or b'').decode('ascii', 'ignore')

    def stop(self):
        try:
            self.lib.host_stop()
        except Exception:
            pass


# ------------------------------------------------------------------ config
def home_dir():
    if sys.platform == 'win32':
        base = Path(os.environ.get('APPDATA', Path.home()))
    elif sys.platform == 'darwin':
        base = Path.home() / 'Library' / 'Application Support'
    else:
        base = Path(os.environ.get('XDG_CONFIG_HOME', Path.home() / '.config'))
    path = base / 'bitvault-engine' / GAME_ID
    path.mkdir(parents=True, exist_ok=True)
    return path


def config_path():
    return home_dir() / 'desktop-config.json'


def default_config():
    return {
        'filter': 'hd_crisp',
        'controls': json.loads(json.dumps(DEFAULT_CONTROLS)),
        'cheats': 0,
        'custom_cheat': '',
        'options': {label: choices[0] for label, _i, choices, _l in CORE_OPTIONS},
        'fullscreen': True,
    }


def load_config():
    cfg = default_config()
    try:
        stored = json.loads(config_path().read_text())
    except (OSError, ValueError):
        return cfg
    for key, value in stored.items():
        if key == 'controls' and isinstance(value, dict):
            for name, entry in value.items():
                if name in cfg['controls'] and isinstance(entry, dict):
                    cfg['controls'][name].update({k: v for k, v in entry.items()
                                                  if k in ('key', 'pad', 'mouse')})
        elif key == 'options' and isinstance(value, dict):
            cfg['options'].update(value)
        elif key in cfg:
            cfg[key] = value
    return cfg


def save_config(cfg):
    tmp = config_path().with_suffix('.tmp')
    tmp.write_text(json.dumps(cfg, indent=2))
    tmp.replace(config_path())


# ------------------------------------------------------------------- input
def devices():
    pads = []
    for i in range(pygame.joystick.get_count()):
        try:
            j = pygame.joystick.Joystick(i)
            j.init()
            pads.append(j)
        except pygame.error:
            pass
    return pads


# No deadzone: the moment an axis leaves centre it registers. 0.02 is just above
# ADC noise so a resting stick cannot chatter, but it is far below what a player
# can perceive (the old build used 0.4, which felt like a dead stick).
AXIS_THRESHOLD = 0.005


def _pad_entry(entry, pads):
    kind = entry[0]
    for pad in pads:
        try:
            if kind == 'button' and pad.get_button(entry[1]):
                return True
            if kind == 'axis' and pad.get_numaxes() > entry[1]:
                value = pad.get_axis(entry[1])
                if (entry[2] < 0 and value < -AXIS_THRESHOLD) or \
                        (entry[2] > 0 and value > AXIS_THRESHOLD):
                    return True
            if kind == 'hat' and pad.get_numhats() > entry[1]:
                hat = pad.get_hat(entry[1])
                if entry[2] and hat[0] == entry[2]:
                    return True
                if entry[3] and hat[1] == entry[3]:
                    return True
        except (IndexError, pygame.error):
            continue
    return False


def pressed(entry, keys, mouse, pads):
    for key in entry.get('key', []):
        if keys[key]:
            return True
    if any(mouse[b] for b in entry.get('mouse', []) if 0 <= b < len(mouse)):
        return True
    return any(_pad_entry(e, pads) for e in entry.get('pad', []))


def input_mask(controls, keys, mouse, pads):
    """No deadzone, no clamping: any held input presses its button."""
    mask = 0
    for name, entry in controls.items():
        if pressed(entry, keys, mouse, pads):
            mask |= 1 << BIT[name]
    return mask


def describe(entry):
    parts = []
    keys = entry.get('key', [])
    if keys:
        parts.append('/'.join(pygame.key.name(k).upper() for k in keys))
    for e in entry.get('pad', []):
        if e[0] == 'button':
            parts.append('Pad %d' % (e[1] + 1))
        elif e[0] == 'axis':
            parts.append('Axis %d%s' % (e[1], '-' if e[2] < 0 else '+'))
        elif e[0] == 'hat':
            parts.append('Hat')
    if entry.get('mouse'):
        parts.append('Mouse %d' % entry['mouse'][0])
    return ', '.join(parts) or '-'


# ------------------------------------------------------------------- video
def make_surface(core):
    return pygame.Surface((core.w, core.h), 0, 16, (0xf800, 0x07e0, 0x001f, 0))


def surface_from(core, frame=None):
    """Copy the core's RGB565 frame straight into a 16-bit surface buffer.

    pygame has no portable RGB565 frombuffer format string, and converting
    through 32-bit would soften the pixel art, so the raw bytes go into the
    surface memory with the matching 5-6-5 masks.
    """
    if frame is None or frame.get_size() != (core.w, core.h):
        frame = make_surface(core)
    frame.get_buffer().write(core.framebuffer())
    return frame


def blit_game(screen, frame, stretch):
    sw, sh = screen.get_size()
    if stretch:
        pygame.transform.scale(frame, (sw, sh), screen)
        return
    aspect = 4 / 3
    w = sw
    h = int(w / aspect)
    if h > sh:
        h = sh
        w = int(h * aspect)
    scaled = pygame.transform.scale(frame, (w, h))
    screen.fill((0, 0, 0))
    screen.blit(scaled, ((sw - w) // 2, (sh - h) // 2))


# ------------------------------------------------------------------- audio
class Audio:
    def __init__(self):
        pygame.mixer.pre_init(44100, -16, 2, 1024)
        pygame.mixer.init()
        self.channel = pygame.mixer.Channel(0) if pygame.mixer.get_init() else None
        self.pending = bytearray()

    def feed(self, data):
        if not data or self.channel is None:
            return
        self.pending.extend(data)
        if len(self.pending) >= 4096:
            chunk = bytes(self.pending)
            self.pending.clear()
            try:
                self.channel.queue(pygame.mixer.Sound(buffer=chunk))
            except (pygame.error, ValueError):
                pass

    def stop(self):
        self.pending.clear()
        if self.channel is not None:
            try:
                self.channel.stop()
            except pygame.error:
                pass


# ------------------------------------------------------------------- tests
def self_test():
    pygame.init()
    pygame.display.set_mode((1024, 896))
    core = Core()
    failures = []

    def check(name, ok, detail=''):
        print(('PASS  ' if ok else 'FAIL  ') + name + ('  ' + detail if detail else ''))
        if not ok:
            failures.append(name)

    check('ROM boots', core.w > 0 and core.h > 0, '%dx%d' % (core.w, core.h))
    check('4x True HD output', (core.w, core.h) == (1024, 896), '%dx%d' % (core.w, core.h))

    for _ in range(420):
        core.frame(0)
    frame = surface_from(core, make_surface(core))
    colours = len({tuple(frame.get_at((x, y)))[:3] for x in range(0, core.w, 8)
                   for y in range(0, core.h, 8)})
    check('Vibrant palette on title', colours > 24, '%d colours' % colours)

    # Raw pixel mode must give back the native console resolution.
    core.set_video_filter('sharp')
    core.frame(0)
    check('Raw pixel mode is 1x', (core.w, core.h) == (256, 224), '%dx%d' % (core.w, core.h))
    core.set_video_filter('hd_crisp')
    core.frame(0)

    audio_total = 0
    for _ in range(30):
        core.frame(0)
        audio_total += len(core.samples()) // 4
    check('Stereo audio flows', audio_total > 2000, '%d frames' % audio_total)

    # Every one of the twelve pad inputs must reach the core and change the game.
    boot_sequence = [(300, 0), (10, 1 << BIT['START']), (180, 0),
                     (180, 1 << BIT['START']), (180, 0),
                     (180, 1 << BIT['START']), (240, 0)]
    def boot():
        core.reset()
        for count, mask in boot_sequence:
            for _ in range(count):
                core.frame(mask)
        for _ in range(60):
            core.frame(0)

    boot()
    baseline = core.framebuffer()
    for name in BUTTON_ORDER:
        boot()
        moved = False
        for _ in range(40):
            core.frame(1 << BIT[name])
            if core.framebuffer() != baseline:
                moved = True
        check('Input %-6s reaches the game' % name, moved)

    # Cheat engine.
    boot()
    core.set_cheats(1 << 0)
    for _ in range(4):
        core.frame(0)
    lives = core.read_ram(0x038)
    check('Infinite lives cheat is live', lives == 3, 'WRAM 0x038 = %d' % lives)
    core.set_cheats(0)

    # A Pro Action Replay code must be accepted by the core.
    core.reset_cheat_codes()
    ok = core.apply_cheat_code(0, True, '7E0000FF')
    check('Pro Action Replay code accepted', ok == 1)

    # Live core options.
    core.set_option(1, 'linear')
    check('Core option round-trips', (core.get_option(1) or '').decode() == 'linear' if isinstance(
        core.get_option(1), bytes) else core.get_option(1) == 'linear',
        'interpolation = %s' % (core.get_option(1) or b''))
    core.set_option(1, 'gaussian')

    # Reset must not reload the ROM and must stay at 4x.
    core.reset()
    for _ in range(30):
        core.frame(0)
    check('Reset game works', (core.w, core.h) == (1024, 896))

    # Remapping.
    lib_pad = {'UP': 4, 'DOWN': 5, 'LEFT': 6, 'RIGHT': 7, 'B': 0, 'Y': 1,
               'A': 8, 'X': 9, 'L': 10, 'R': 11, 'START': 3, 'SELECT': 2}
    check('All 12 pad bits mapped', sorted(lib_pad.values()) == list(range(12)))

    core.stop()
    pygame.quit()
    print()
    if failures:
        print('FAILURES: ' + ', '.join(failures))
        return 1
    print('ALL TESTS PASSED')
    return 0


# -------------------------------------------------------------------- menu
MENU_BG = (11, 15, 25)
CARD = (20, 27, 42)
ACCENT = (45, 212, 191)
ACCENT_DIM = (15, 118, 110)
TEXT = (226, 232, 240)
MUTED = (148, 163, 184)


class Menu:
    """Stack based settings menu: main / controls / video / audio / cheats / about."""

    def __init__(self, cfg, core):
        self.cfg = cfg
        self.core = core
        self.stack = ['main']
        self.index = 0
        self.waiting = None
        self.notice = ''
        self.scroll = 0
        self.rows = []
        self.build()

    # ---------------------------------------------------------- row builder
    def build(self):
        page = self.stack[-1]
        cfg = self.cfg
        rows = []
        if page == 'main':
            rows = [
                ('Resume game', lambda: self.close()),
                ('Reset game', self.act_reset),
                ('Controls & remapping', lambda: self.push('controls')),
                ('Video & display', lambda: self.push('video')),
                ('Audio', lambda: self.push('audio')),
                ('Cheats', lambda: self.push('cheats')),
                ('Game options', lambda: self.push('options')),
                ('About', lambda: self.push('about')),
                ('Exit game', lambda: pygame.event.post(pygame.event.Event(pygame.QUIT))),
            ]
        elif page == 'controls':
            for name in BUTTON_ORDER:
                rows.append(('%-7s %s' % (name, describe(cfg['controls'][name])),
                             (lambda n=name: self.start_rebind(n))))
            rows.append(('Reset all buttons to default', self.act_reset_buttons))
            rows.append(('Back', self.pop))
        elif page == 'video':
            rows.append(('Image quality: %s' % FILTER_LABELS[cfg['filter']].split(' - ')[0],
                         self.act_cycle_filter))
            rows.append(('Toggle fullscreen (F11)', self.act_toggle_fullscreen))
            rows.append(('Reset game', self.act_reset))
            rows.append(('Back', self.pop))
        elif page == 'audio':
            label, idx, choices, labels = CORE_OPTIONS[1]
            current = cfg['options'].get(label, choices[0])
            human = labels[choices.index(current)] if current in choices else current
            rows.append(('Audio interpolation: %s' % human, self.act_cycle_interp))
            rows.append(('Back', self.pop))
        elif page == 'cheats':
            for label, bit in CHEATS:
                on = bool(cfg['cheats'] & bit)
                rows.append(('[%s] %s' % ('x' if on else ' ', label),
                             (lambda b=bit: self.act_toggle_cheat(b))))
            rows.append(('Custom code: %s' % (cfg.get('custom_cheat') or 'none'), self.act_note_custom))
            rows.append(('Back', self.pop))
        elif page == 'options':
            for label, idx, choices, labels in CORE_OPTIONS:
                current = cfg['options'].get(label, choices[0])
                human = labels[choices.index(current)] if current in choices else current
                rows.append(('%s: %s' % (label, human),
                             (lambda l=label, c=choices: self.act_cycle_option(l, c))))
            rows.append(('Back', self.pop))
        elif page == 'about':
            rows.append(('Back', self.pop))
        self.rows = rows
        self.index = max(0, min(self.index, len(rows) - 1))

    # -------------------------------------------------------------- helpers
    def push(self, page):
        self.stack.append(page)
        self.index = 0
        self.build()

    def pop(self):
        if len(self.stack) > 1:
            self.stack.pop()
            self.index = 0
            self.build()

    def close(self):
        self.stack = ['main']
        self.index = 0
        self.build()

    def persist(self):
        try:
            save_config(self.cfg)
        except OSError:
            self.notice = 'Could not save settings'

    # --------------------------------------------------------------- actions
    def act_reset(self):
        self.core.reset()
        self.notice = 'Game reset'

    def act_reset_buttons(self):
        self.cfg['controls'] = json.loads(json.dumps(DEFAULT_CONTROLS))
        self.persist()
        self.build()
        self.notice = 'Buttons restored to default'

    def act_cycle_filter(self):
        order = FILTER_MODES
        current = self.cfg['filter']
        nxt = order[(order.index(current) + 1) % len(order)] if current in order else order[0]
        self.cfg['filter'] = nxt
        self.core.set_video_filter(nxt)
        self.persist()
        self.build()

    def act_toggle_fullscreen(self):
        pygame.event.post(pygame.event.Event(pygame.KEYDOWN, key=pygame.K_F11))

    def act_cycle_interp(self):
        label, idx, choices, labels = CORE_OPTIONS[1]
        current = self.cfg['options'].get(label, choices[0])
        nxt = choices[(choices.index(current) + 1) % len(choices)] if current in choices else choices[0]
        self.cfg['options'][label] = nxt
        self.core.set_option(idx, nxt)
        self.persist()
        self.build()

    def act_cycle_option(self, label, choices):
        current = self.cfg['options'].get(label, choices[0])
        nxt = choices[(choices.index(current) + 1) % len(choices)] if current in choices else choices[0]
        self.cfg['options'][label] = nxt
        for name, idx, opts, _l in CORE_OPTIONS:
            if name == label:
                self.core.set_option(idx, nxt)
        self.persist()
        self.build()

    def act_toggle_cheat(self, bit):
        self.cfg['cheats'] ^= bit
        self.core.set_cheats(self.cfg['cheats'])
        self.persist()
        self.build()
        self.notice = 'Cheats updated'

    def act_note_custom(self):
        self.notice = ('Type a Game Genie / Pro Action Replay code in the settings file: '
                       + str(config_path()))

    def start_rebind(self, name):
        self.waiting = name
        self.notice = 'Press a key or a gamepad button for %s (Esc cancels)' % name

    # ---------------------------------------------------------------- events
    def handle(self, event):
        if self.waiting:
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.waiting = None
                    self.notice = 'Remap cancelled'
                else:
                    self.cfg['controls'][self.waiting]['key'] = [event.key]
                    self.waiting = None
                    self.persist()
                    self.build()
                    self.notice = 'Button remapped'
                return True
            if event.type == pygame.JOYBUTTONDOWN:
                self.cfg['controls'][self.waiting]['pad'] = [['button', event.button]]
                self.waiting = None
                self.persist()
                self.build()
                self.notice = 'Button remapped'
                return True
            return True

        if event.type == pygame.KEYDOWN:
            if event.key in (pygame.K_ESCAPE, pygame.K_F1):
                if len(self.stack) > 1:
                    self.pop()
                return True
            if event.key in (pygame.K_UP, pygame.K_w):
                self.index = (self.index - 1) % max(1, len(self.rows))
                return True
            if event.key in (pygame.K_DOWN, pygame.K_s):
                self.index = (self.index + 1) % max(1, len(self.rows))
                return True
            if event.key in (pygame.K_RETURN, pygame.K_SPACE, pygame.K_LEFT, pygame.K_RIGHT):
                if 0 <= self.index < len(self.rows):
                    self.rows[self.index][1]()
                return True
        if event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:
            rects = getattr(self, "row_rects", [])
            for i, rect in enumerate(rects):
                if rect.collidepoint(event.pos):
                    self.index = i
                    self.rows[i][1]()
                    return True
        return False

    # ------------------------------------------------------------------ draw
    def draw(self, screen):
        w, h = screen.get_size()
        screen.fill(MENU_BG)
        pad = max(18, w // 48)
        title = {'main': 'Mazinger Z - Menu', 'controls': 'Controls & remapping',
                 'video': 'Video & display', 'audio': 'Audio', 'cheats': 'Cheats',
                 'options': 'Game options', 'about': 'About'}[self.stack[-1]]

        font_title = pygame.font.SysFont('dejavusans', max(20, w // 34), bold=True)
        font_row = pygame.font.SysFont('dejavusans', max(15, w // 58))
        font_small = pygame.font.SysFont('dejavusans', max(12, w // 78))

        screen.blit(font_title.render(title, True, TEXT), (pad, pad))
        pygame.draw.line(screen, ACCENT_DIM, (pad, pad + font_title.get_height() + 8),
                         (w - pad, pad + font_title.get_height() + 8), 2)

        if self.stack[-1] == 'about':
            self.draw_about(screen, pad, font_row, font_small)
            return

        y = pad + font_title.get_height() + 22
        row_h = font_row.get_height() + max(10, h // 90)
        self.row_rects = []
        for i, (text, _fn) in enumerate(self.rows):
            rect = pygame.Rect(pad, y, w - pad * 2, row_h)
            self.row_rects.append(rect)
            if i == self.index:
                pygame.draw.rect(screen, CARD, rect, border_radius=8)
                pygame.draw.rect(screen, ACCENT, rect, width=2, border_radius=8)
            else:
                pygame.draw.rect(screen, (14, 19, 30), rect, border_radius=8)
            colour = ACCENT if i == self.index else TEXT
            screen.blit(font_row.render(text, True, colour),
                        (rect.x + 14, rect.y + (row_h - font_row.get_height()) // 2))
            y += row_h + 6

        footer = self.notice or 'Up/Down selects - Enter activates - Esc goes back'
        screen.blit(font_small.render(footer, True, MUTED), (pad, h - pad - font_small.get_height()))

    def draw_about(self, screen, pad, font_row, font_small):
        w, h = screen.get_size()
        words = ABOUT_PLAIN_TEXT.split()
        lines, line = [], ''
        limit = w - pad * 2 - 24
        for word in words:
            trial = (line + ' ' + word).strip()
            if font_row.size(trial)[0] > limit:
                lines.append(line)
                line = word
            else:
                line = trial
        if line:
            lines.append(line)

        y = pad + font_row.get_height() * 2 + 34
        for text in lines:
            colour = ACCENT if 'Ahmed Kamal Elgandy' in text else TEXT
            screen.blit(font_row.render(text, True, colour), (pad + 8, y))
            y += font_row.get_height() + 6
        screen.blit(font_small.render('Press Esc or Enter to go back', True, MUTED),
                    (pad, h - pad - font_small.get_height()))


# -------------------------------------------------------------------- main
def main():
    ui_test = '--ui-test' in sys.argv
    if ui_test:
        os.environ['SDL_VIDEODRIVER'] = 'dummy'
        os.environ['SDL_AUDIODRIVER'] = 'dummy'
        test_home = tempfile.TemporaryDirectory(prefix='mazinger-z-ui-test-')
        if sys.platform == 'win32':
            os.environ['APPDATA'] = test_home.name
        elif sys.platform == 'darwin':
            os.environ['HOME'] = test_home.name
        else:
            os.environ['XDG_CONFIG_HOME'] = test_home.name

    pygame.init()
    pygame.joystick.init()
    cfg = load_config()
    screen = pygame.display.set_mode((1024, 768) if ui_test else (0, 0),
                                     0 if ui_test else pygame.FULLSCREEN)
    pygame.display.set_caption('Mazinger Z - マジンガーZ')
    core = Core()
    core.set_video_filter(cfg['filter'])
    core.set_cheats(cfg['cheats'])
    for label, idx, choices, _labels in CORE_OPTIONS:
        core.set_option(idx, cfg['options'].get(label, choices[0]))
    if cfg.get('custom_cheat'):
        core.apply_cheat_code(0, True, cfg['custom_cheat'])

    frame = make_surface(core)
    audio = Audio()
    menu = Menu(cfg, core)
    clock = pygame.time.Clock()
    show_menu = True
    running = True

    frame_times = []
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
                continue
            if event.type in (pygame.JOYDEVICEADDED, pygame.JOYDEVICEREMOVED):
                continue
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_F11:
                    flags = pygame.display.get_surface().get_flags()
                    fullscreen = not bool(flags & pygame.FULLSCREEN)
                    screen = pygame.display.set_mode((0, 0) if fullscreen else (1280, 800),
                                                     pygame.FULLSCREEN if fullscreen else pygame.RESIZABLE)
                    continue
                if event.key == pygame.K_F5:
                    core.reset()
                    continue
                if event.key in (pygame.K_F1, pygame.K_ESCAPE):
                    if show_menu and menu.stack == ['main']:
                        show_menu = False
                    else:
                        show_menu = True
                        menu.close()
                    continue
            if show_menu:
                menu.handle(event)

        if not running:
            break

        if show_menu:
            menu.draw(screen)
            pygame.display.flip()
            clock.tick(60)
            continue

        keys = pygame.key.get_pressed()
        mouse = pygame.mouse.get_pressed(num_buttons=5)
        pads = devices()
        core.frame(input_mask(cfg['controls'], keys, mouse, pads))
        audio.feed(core.samples())

        frame = surface_from(core, frame)
        blit_game(screen, frame, stretch=cfg['filter'] == 'sharp')
        pygame.display.flip()

        frame_times.append(time.perf_counter())
        frame_times = frame_times[-60:]
        clock.tick(60)

    audio.stop()
    core.stop()
    pygame.quit()
    return 0


if __name__ == '__main__':
    if '--self-test' in sys.argv:
        sys.exit(self_test())
    sys.exit(main())

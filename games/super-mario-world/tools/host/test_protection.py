#!/usr/bin/env python3
"""Drive the shipping native protections and real SMB stage transition logic."""
import ctypes
from pathlib import Path
from drive import App
ROOT = Path(__file__).resolve().parents[2]
a = App(ROOT/'app/src/main/assets/mario.nes', '/tmp/nes-protection')
a.run(120); a.press('START'); a.run(350)
lib = a.lib
lib.retro_get_memory_data.argtypes = [ctypes.c_uint]
lib.retro_get_memory_data.restype = ctypes.POINTER(ctypes.c_uint8)
ram = lib.retro_get_memory_data(2)
protect = lib.Java_com_midoali_nes_NesCore_nativeMarioProtection
protect.argtypes = [ctypes.c_void_p, ctypes.c_void_p, ctypes.c_int]
def step(n, flags=7):
    for _ in range(n):
        protect(None, None, flags)
        a.run(1)
def ready():
    for _ in range(2000):
        step(1)
        if ram[0x770] == 1 and ram[0x772] == 3 and ram[0xe] == 8:
            return
    raise AssertionError('stage did not enter normal play')
def stage(): return (ram[0x75f]+1, ram[0x75c]+1)
def check_stage():
    ready(); step(3)
    assert ram[0x75a] == 8 and ram[0x79f] > 0, (stage(), ram[0x75a], ram[0x79f])
    # Inject a falling position in normal play; rescue should move Mario upwards.
    ram[0x743]=0; ram[0x759]=0; ram[0xb5]=1; ram[0xce]=0xe1; ram[0x9f]=3
    protect(None, None, 7)
    assert ram[0xb5] == 1 and ram[0xce] == 0x80 and ram[0x9f] == 0xf8
    step(1)
    print('protection verified in world-stage', stage())
def next_stage():
    # Fast-forward the flagpole ending: the ROM itself performs NextArea and
    # reinitializes the next stage, exactly as it would during normal play.
    ram[0x0e]=5; ram[0x746]=5
    step(1)
    ready()
for world in range(1, 9):
    if world > 1:
        # Fast-forward castle victory; the ROM loads the next world.
        ram[0x770] = 2; ram[0x772] = 4; ram[0x7a1] = 0
        step(1); ready()
    for level in range(1, 5):
        assert stage() == (world, level), stage()
        check_stage()
        if level < 4: next_stage()
# Disable: lives and star no longer forced; star cheat cleared immediately.
protect(None, None, 0)
assert ram[0x79f] == 0
ram[0x75a]=2
ram[0xb5]=1; ram[0xce]=0xe1; ram[0x9f]=3
protect(None, None, 0)
assert ram[0x75a] == 2 and ram[0xce] == 0xe1
print('disabling, stage and world transitions: PASS')

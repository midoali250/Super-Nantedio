#!/usr/bin/env python3
"""Check the shipping JNI lives operation against running SMB RAM."""
import ctypes
from pathlib import Path
from drive import App
root = Path(__file__).resolve().parents[2]
app = App(root / 'app/src/main/assets/mario.nes', '/tmp/nes-lives-test')
app.run(120); app.press('START'); app.run(350)
lib = app.lib
lib.retro_get_memory_data.argtypes = [ctypes.c_uint]
lib.retro_get_memory_data.restype = ctypes.POINTER(ctypes.c_uint8)
ram = lib.retro_get_memory_data(2)
assert ram[0x75a] == 2, f'expected SMB initial lives minus one: {ram[0x75a]}'
ram[0x75a] = 0
lib.Java_com_midoali_nes_NesCore_nativeInfiniteLives(None, None)
assert ram[0x75a] == 8
app.run(3)
assert ram[0x75a] == 8
ram[0x75a] = 2
app.run(3)
assert ram[0x75a] == 2, 'disabled cheat must not force lives'
print('Lives cheat RAM and off behavior: PASS')

#!/usr/bin/env python3
"""Measure real SMB peak height for held jump durations using the shipped core."""
import ctypes
import subprocess
import sys
from pathlib import Path
from drive import App
root = Path(__file__).resolve().parents[2]
if len(sys.argv) == 2:
    duration = int(sys.argv[1])
    a = App(root / 'app/src/main/assets/mario.nes', '/tmp/nes-jump-measure')
    a.run(120); a.press('START'); a.run(350)
    lib = a.lib
    lib.retro_get_memory_data.argtypes = [ctypes.c_uint]
    lib.retro_get_memory_data.restype = ctypes.POINTER(ctypes.c_uint8)
    ram = lib.retro_get_memory_data(2)
    initial = ram[0xce]
    peak = initial
    for i in range(95):
        a.mask = 1 << 8 if i < duration else 0
        a.run(1)
        if ram[0xb5] == 1: peak = min(peak, ram[0xce])
    print(f'{duration},{initial},{peak},{initial-peak}')
else:
    for d in (4, 22, 32, 40):
        output = subprocess.check_output([sys.executable, __file__, str(d)], text=True)
        print('HOLD_FRAMES,GROUND_Y,PEAK_Y,RISE_PIXELS:', output.strip())

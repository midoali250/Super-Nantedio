#!/usr/bin/env python3
"""Replay the shipping Java virtual pad against the actual World ROM/core."""
import ctypes
from pathlib import Path
import subprocess
from drive import App
root = Path(__file__).resolve().parents[2]
target = Path('/tmp/world-vpad-scenario'); target.mkdir(exist_ok=True)
java = root / 'app/src/main/java/com/midoali/nes'
subprocess.run(['javac', '-d', str(target), *(str(java/(n+'.java')) for n in ('VirtualPad','Zapper')), str(root/'tools/vpad/Scenario.java')], check=True)
masks = subprocess.check_output(['java','-cp',str(target),'com.midoali.nes.Scenario'], text=True).splitlines()
a = App(root/'app/src/main/assets/mario.nes', '/tmp/world-gameplay-test')
lib=a.lib; lib.retro_get_memory_data.argtypes=[ctypes.c_uint]; lib.retro_get_memory_data.restype=ctypes.POINTER(ctypes.c_uint8)
ram=lib.retro_get_memory_data(2); positions={}
for frame,line in enumerate(masks):
    mask, gx, gy, trigger = map(int,line.split())
    a.mask=mask
    # No Zapper action is needed in this game; joypad masks are unchanged.
    a.run(1)
    if frame in (469, 530, 550):
        positions[frame]=(ram[0x770],ram[0x0e],ram[0x6d],ram[0x86],ram[0xce])
assert positions[469][0:2] == (1,8), positions
assert positions[530][3] > positions[469][3], positions
assert positions[550][4] < positions[530][4], positions
assert a.audio_frames > len(masks)*700, a.audio_frames
print('PASS: SMB title START, World 1-1, stick movement, BIG JUMP, and generated audio',positions)

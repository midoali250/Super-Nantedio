import sys,ctypes
sys.path.insert(0,'tools/host');from drive import App
mode=int(sys.argv[1]);x=App('app/src/main/assets/mario.nes','/tmp/nes-enemy-test');x.run(60);x.press('START');x.run(80);x.press('START');x.run(240)
l=x.lib;l.retro_get_memory_data.restype=ctypes.POINTER(ctypes.c_uint8);r=l.retro_get_memory_data(2);f=l.Java_com_midoali_nes_NesCore_nativeMarioProtection; f.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_int]
x.mask=1<<7
for i in range(450):
 f(None,None,mode);x.run(1)
 if r[0xe] in (0xb,6):
  print('death',i,'flag',mode, 'lives',r[0x75a]); assert mode == 0; break
else:
 print('alive at',i,'x',r[0x86], 'page',r[0x6d], 'routine',r[0xe], 'lives',r[0x75a]); assert mode == 2

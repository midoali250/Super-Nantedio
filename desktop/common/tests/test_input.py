import os,sys
os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
sys.path.insert(0,os.path.dirname(os.path.dirname(__file__)))
import app
class Keys:
    def __getitem__(self,k): return k == app.pygame.K_SPACE
class Empty:
    def __getitem__(self,k): return False
class Pad:
    def get_numbuttons(self): return 10
    def get_button(self,n): return n==1
    def get_numaxes(self): return 2
    def get_axis(self,n): return -0.8 if n==0 else 0
    def get_numhats(self): return 0
b=app.DEFAULTS
assert app.mask_from_inputs(b,Keys(),(False,)*5,[]) & (1<<8)
assert app.mask_from_inputs(b,Empty(),(True,False,False,False,False),[]) & (1<<8)
m=app.mask_from_inputs(b,Empty(),(False,)*5,[Pad()]);assert m & (1<<6) and m & 1
print('PASS: keyboard, mouse and simulated joystick mappings')

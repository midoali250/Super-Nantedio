import os,sys
os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
sys.path.insert(0,os.path.dirname(os.path.dirname(__file__)))
import app
class Keys:
    def __getitem__(self,k):return k in (app.pygame.K_a,app.pygame.K_x)
class Empty:
    def __getitem__(self,k):return False
class Pad:
    def get_numbuttons(self):return 10
    def get_button(self,n):return n==2
    def get_numaxes(self):return 2
    def get_axis(self,n):return -.8 if n==0 else 0
    def get_numhats(self):return 0
assert app.input_mask(app.DEFAULTS,Keys(),(False,)*5,[],0)&(1<<8)
assert app.input_mask(app.DEFAULTS,Keys(),(False,)*5,[],0)&1
assert not app.input_mask(app.DEFAULTS,Keys(),(False,)*5,[],7)&(1<<8)
assert not app.input_mask(app.DEFAULTS,Keys(),(False,)*5,[],7)&1
assert app.input_mask(app.DEFAULTS,Empty(),(True,False,False,False,False),[],0)&(1<<8)
m=app.input_mask(app.DEFAULTS,Empty(),(False,)*5,[Pad()],0);assert m&(1<<6) and m&1
print('PASS: keyboard, mouse, joystick, repeat actions')

import os,sys,tempfile,unittest,json
from pathlib import Path
from unittest.mock import patch
os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
import pygame
import controls

class Pad:
 def get_init(self):return True
 def get_guid(self):return 'test-guid'
 def get_instance_id(self):return 17
 def get_name(self):return 'Virtual test gamepad'
 def get_numbuttons(self):return 12
 def get_button(self,n):return n==6
 def get_numaxes(self):return 2
 def get_axis(self,n):return -0.8 if n==0 else 0
 def get_numhats(self):return 1
 def get_hat(self,n):return (0,0)

class ControlsTests(unittest.TestCase):
 def setUp(self):pygame.init();self.screen=pygame.display.set_mode((1280,720));pygame.event.clear()
 def tearDown(self):pygame.quit()
 def test_capture_keyboard_and_pad_through_real_settings_screen(self):
  with tempfile.TemporaryDirectory() as d,patch('controls.data_dir',return_value=Path(d)):
   with patch('controls.scan_gamepads',return_value=[Pad()]):
    events=[pygame.event.Event(pygame.MOUSEBUTTONDOWN,button=1,pos=(500,200)),pygame.event.Event(pygame.KEYDOWN,key=pygame.K_t),pygame.event.Event(pygame.MOUSEBUTTONDOWN,button=1,pos=(800,320)),pygame.event.Event(pygame.JOYBUTTONDOWN,instance_id=17,button=6),pygame.event.Event(pygame.KEYDOWN,key=pygame.K_ESCAPE)]
    for e in events:pygame.event.post(e)
    controls.control_screen(self.screen)
   config=controls.read_controls();self.assertEqual(config['keyboard']['4'],pygame.K_t);self.assertEqual(config['gamepads']['test-guid']['8'],{'type':'button','index':6})
   class Keys:
    def __getitem__(self,key):return key==pygame.K_t
   bits=controls.input_bits([Pad()],config,Keys());self.assertIn(4,bits);self.assertIn(8,bits);self.assertIn(6,bits)
 def test_axis_hat_and_instance_filter(self):
  axis=pygame.event.Event(pygame.JOYAXISMOTION,instance_id=17,axis=1,value=-.8)
  self.assertEqual(controls.captured_binding(axis,17),{'type':'axis','index':1,'direction':-1})
  self.assertIsNone(controls.captured_binding(axis,18))
  hat=pygame.event.Event(pygame.JOYHATMOTION,instance_id=17,hat=0,value=(0,1))
  self.assertEqual(controls.captured_binding(hat,17),{'type':'hat','index':0,'component':1,'direction':1})
 def test_mapping_is_per_gamepad_and_malformed_is_rejected(self):
  c=controls.sanitize_controls({'keyboard':{'8':pygame.K_ESCAPE,'0':pygame.K_b},'gamepads':{'test-guid':{'8':{'type':'button','index':6},'0':{'type':'button','index':-1}}}})
  self.assertNotIn('8',c['keyboard']);self.assertEqual(c['keyboard']['0'],pygame.K_b);self.assertNotIn('0',c['gamepads']['test-guid'])
  self.assertTrue(controls.binding_active(Pad(),c['gamepads']['test-guid']['8']))
 def test_reset_confirmation_cancel_and_confirm_through_main_settings(self):
  import launcher
  with tempfile.TemporaryDirectory() as d:
   base=Path(d);root=base/'resources';(root/'assets').mkdir(parents=True);(root/'drive-index.json').write_text(json.dumps({'files':[],'excluded_ids':[]}));icon=pygame.Surface((8,8));pygame.image.save(icon,root/'assets/app-icon.png')
   data=base/'.retro-collection';(data/'manual-saves').mkdir(parents=True);saved=data/'manual-saves'/'test.state';saved.write_text('keep until confirmed')
   def run(keys):
    events=[pygame.event.Event(pygame.KEYDOWN,key=k,unicode='') for k in keys]
    with patch.object(launcher,'ROOT',root),patch('pathlib.Path.home',return_value=base),patch.object(sys,'argv',['launcher.py','--smoke']),patch('pygame.event.get',return_value=events),patch.object(launcher,'scan_gamepads',return_value=[]):
     launcher.BACKGROUND_CACHE.clear();launcher.main()
   run([pygame.K_g,pygame.K_r,pygame.K_n]);self.assertTrue(saved.exists())
   run([pygame.K_g,pygame.K_r,pygame.K_y]);self.assertFalse(data.exists())
 def test_factory_reset_only_deletes_app_directory_and_all_saves(self):
  with tempfile.TemporaryDirectory() as d:
   base=Path(d);root=base/'.retro-collection';(root/'manual-saves').mkdir(parents=True);(root/'manual-saves'/'test.state').write_text('save');(root/'controls.json').write_text('mapping');(root/'preferences.json').write_text('favorite');outside=base/'keep.txt';outside.write_text('untouched')
   controls.reset_application(root);self.assertFalse(root.exists());self.assertEqual(outside.read_text(),'untouched')
if __name__=='__main__':unittest.main()

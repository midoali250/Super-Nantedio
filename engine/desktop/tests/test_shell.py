import os,tempfile,unittest
from pathlib import Path
os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
import pygame
import launcher
from game_session import fit_frame, menu_next
class DesktopShellTests(unittest.TestCase):
 def setUp(self):pygame.init();self.screen=pygame.display.set_mode((1280,720))
 def tearDown(self):pygame.quit()
 def test_single_list_and_settings_render(self):
  self.assertEqual(launcher.CATEGORIES,['ALL','FAVORITES'])
  with tempfile.TemporaryDirectory() as temp:
   root=Path(temp);(root/'assets').mkdir();(root/'thumbnails').mkdir();(root/'NOTICE.md').write_text('Attribution')
   icon=pygame.Surface((30,30));icon.fill('blue');pygame.image.save(icon,root/'assets/app-icon.png')
   thumb=pygame.Surface((20,20));thumb.fill('red');pygame.image.save(thumb,root/'thumbnails/test.png')
   old=launcher.ROOT;launcher.ROOT=root;launcher.THUMB_CACHE.clear()
   try:
    launcher.render(self.screen,[{'id':'test','title':'Test Title','system':'NES'}],'ALL','',0,set(),'',False,True,'FIT')
    self.assertIsNotNone(launcher.thumbnail('test'))
   finally:launcher.ROOT=old;launcher.THUMB_CACHE.clear()
 def test_about_button_and_text(self):
  self.assertTrue(launcher.about_button_hit(1100,415))
  self.assertFalse(launcher.about_button_hit(990,415))
  self.assertIn('Ahmed Kamal Elgandy',launcher.ABOUT_TEXT)
  self.assertIn('original production companies.',launcher.ABOUT_TEXT)
 def test_update_key_validation(self):
  import base64,json
  with tempfile.TemporaryDirectory() as temp:
   root=Path(temp);(root/'updates').mkdir();file=root/'updates/public-key.json'
   file.write_text(json.dumps({'platform':'linux','algorithm':'Ed25519','public_key_base64':base64.b64encode(bytes(32)).decode()}))
   self.assertEqual(len(launcher.verify_packaged_update_key(root,'linux')),32)
   with self.assertRaises(ValueError):launcher.verify_packaged_update_key(root,'windows')
   file.write_text(json.dumps({'platform':'linux','algorithm':'Ed25519','public_key_base64':'bad'}))
   with self.assertRaises(ValueError):launcher.verify_packaged_update_key(root,'linux')
 def test_scroll_boundaries(self):
  self.assertEqual(launcher.scroll_selection(0,-1,97),3)
  self.assertEqual(launcher.scroll_selection(0,1,97),0)
  self.assertEqual(launcher.scroll_selection(96,-1,97),96)
  self.assertEqual(launcher.scroll_selection(0,-1,0),0)
 def test_game_menu_wrap(self):
  self.assertEqual(menu_next(0,-1,9),8)
  self.assertEqual(menu_next(8,1,9),0)
  self.assertEqual(menu_next(0,1,0),0)
 def test_uncropped_frame_fit(self):
  self.assertEqual(fit_frame((4,3),(1920,1080)).size,(1440,1080))
  self.assertEqual(fit_frame((4,3),(3840,2160)).size,(2880,2160))
if __name__=='__main__':unittest.main()

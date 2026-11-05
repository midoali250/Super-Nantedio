import json,tempfile,unittest
from pathlib import Path
from preferences import read_preferences,write_preferences,sanitize
class PreferencesTests(unittest.TestCase):
 def test_defaults_and_corrupt(self):
  with tempfile.TemporaryDirectory() as tmp:
   path=Path(tmp)/'settings.json';self.assertEqual(read_preferences(path)['display_mode'],'FIT')
   path.write_text('invalid',encoding='utf8');self.assertEqual(read_preferences(path)['favorites'],[])
 def test_roundtrip_and_normalize(self):
  with tempfile.TemporaryDirectory() as tmp:
   path=Path(tmp)/'sub'/'settings.json'
   write_preferences({'display_mode':'STRETCH','scaling':'SMOOTH','favorites':['b','a','a']},path)
   self.assertEqual(read_preferences(path),{'display_mode':'STRETCH','scaling':'SMOOTH','favorites':['a','b']})
   self.assertEqual(list(path.parent.glob('*.tmp')),[])
 def test_untrusted_values(self):
  self.assertEqual(sanitize({'display_mode':'bad','scaling':5,'favorites':'bad'}),{'display_mode':'FIT','scaling':'SHARP','favorites':[]})
if __name__=='__main__':unittest.main()

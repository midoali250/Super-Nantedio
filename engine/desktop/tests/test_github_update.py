import base64,hashlib,json,tempfile,unittest,urllib.error
from pathlib import Path
from unittest.mock import patch
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives.serialization import Encoding,PublicFormat
import github_update as u
from signed_updates import UpdateError
class Response:
 status=200
 def __init__(self,data):self.data=data
 def read(self,n):v=self.data[:n];self.data=self.data[n:];return v
 def __enter__(self):return self
 def __exit__(self,*args):pass
class Opener:
 def __init__(self,data):self.data=data
 def open(self,*args,**kwargs):return Response(self.data)
class Tests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory();self.root=Path(self.temp.name);(self.root/'updates').mkdir();self.k=Ed25519PrivateKey.generate();self.pub=self.k.public_key().public_bytes(Encoding.Raw,PublicFormat.Raw)
  (self.root/'updates/version.json').write_text(json.dumps({'version_code':2}));(self.root/'updates/public-key.json').write_text(json.dumps({'algorithm':'Ed25519','platform':'windows','public_key_base64':base64.b64encode(self.pub).decode()}));self.data=b'signed update'
  self.m={'schema_version':1,'product':'akg-retro-games','platform':'windows','version_code':3,'size_bytes':len(self.data),'sha256':hashlib.sha256(self.data).hexdigest(),'url':'https://github.com/midoali250/akg-retro-games-windows/releases/download/v3/game.exe'}
 def tearDown(self):self.temp.cleanup()
 def env(self,manifest):
  raw=json.dumps(manifest,separators=(',',':')).encode();return json.dumps({'payload':base64.b64encode(raw).decode(),'signature':base64.b64encode(self.k.sign(raw)).decode()}).encode()
 def test_signed_update_and_version(self):
  with patch('urllib.request.build_opener',return_value=Opener(self.env(self.m))):
   self.assertEqual(u.check('windows',self.root)['version_code'],3);self.assertIsNone(u.check('windows',self.root,3))
 def test_reject_wrong_repository_and_tampering(self):
  m=dict(self.m,url='https://github.com/attacker/game/releases/download/v3/game.exe')
  with patch('urllib.request.build_opener',return_value=Opener(self.env(m))):
   with self.assertRaises(UpdateError):u.check('windows',self.root,2)
  raw=bytearray(self.env(self.m));raw[-3]^=1
  with patch('urllib.request.build_opener',return_value=Opener(bytes(raw))):
   with self.assertRaises(UpdateError):u.check('windows',self.root,2)
 def test_three_independent_platform_repositories(self):
  for platform,extension in [('windows','.exe'),('linux','.AppImage'),('macos','.zip')]:
   key={'algorithm':'Ed25519','platform':platform,'public_key_base64':base64.b64encode(self.pub).decode()}
   (self.root/'updates/public-key.json').write_text(json.dumps(key))
   manifest=dict(self.m,platform=platform,url='https://github.com/midoali250/akg-retro-games-'+platform+'/releases/download/v3/game'+extension)
   class Recording(Opener):
    requested=''
    def open(self,request,*args,**kwargs):
     self.requested=request.full_url;return super().open(request,*args,**kwargs)
   response=Recording(self.env(manifest))
   with patch('urllib.request.build_opener',return_value=response):self.assertEqual(u.check(platform,self.root)['platform'],platform)
   self.assertIn('/akg-retro-games-'+platform+'/releases/latest/download/',response.requested)
 def test_no_published_manifest_is_no_update(self):
  class Missing:
   def open(self,*args,**kwargs):raise urllib.error.HTTPError('https://github.com',404,'Not Found',{},None)
  with patch('urllib.request.build_opener',return_value=Missing()):self.assertIsNone(u.check('windows',self.root))
 def test_user_requested_verified_download(self):
  with patch('urllib.request.build_opener',return_value=Opener(self.data)):
   dest=u.download('windows',self.m,self.root/'downloads');self.assertEqual(dest.read_bytes(),self.data)
  with patch('urllib.request.build_opener',return_value=Opener(b'wrong')):
   with self.assertRaises(UpdateError):u.download('windows',self.m,self.root/'downloads')
if __name__=='__main__':unittest.main()

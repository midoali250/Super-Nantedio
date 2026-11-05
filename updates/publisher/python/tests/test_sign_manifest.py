import base64,json,sys,tempfile,unittest
from pathlib import Path
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives.serialization import Encoding,PrivateFormat,PublicFormat,NoEncryption
sys.path.insert(0,str(Path(__file__).resolve().parents[3]/'client'/'python'))
from signed_updates import verify_manifest,UpdateError
from sign_manifest import create_manifest
class PublisherTests(unittest.TestCase):
 def setUp(self):
  self.key=Ed25519PrivateKey.generate();self.seed=base64.b64encode(self.key.private_bytes(Encoding.Raw,PrivateFormat.Raw,NoEncryption())).decode();self.pub=self.key.public_key().public_bytes(Encoding.Raw,PublicFormat.Raw);self.cfg={'algorithm':'Ed25519','platform':'windows','public_key_base64':base64.b64encode(self.pub).decode()};self.temp=tempfile.TemporaryDirectory();self.path=Path(self.temp.name)/'game.exe';self.path.write_bytes(b'valid package');self.url='https://github.com/midoali250/akg-retro-games-windows/releases/download/v2/game.exe'
 def tearDown(self):self.temp.cleanup()
 def test_publisher_and_client_interoperate(self):
  result=create_manifest(self.path,'windows',2,self.url,self.seed,self.cfg);m=verify_manifest(result,self.pub,'akg-retro-games','windows',1,{('github.com',443)});self.assertEqual(m['size_bytes'],13)
  with self.assertRaises(UpdateError):verify_manifest(result,bytes(32),'akg-retro-games','windows',1,{('github.com',443)})
 def test_wrong_key_platform_and_url_rejected(self):
  with self.assertRaises(ValueError):create_manifest(self.path,'linux',2,self.url,self.seed,self.cfg)
  with self.assertRaises(ValueError):create_manifest(self.path,'windows',2,'https://evil.example/game.exe',self.seed,self.cfg)
  with self.assertRaises(ValueError):create_manifest(self.path,'windows',2,self.url,base64.b64encode(bytes(32)).decode(),self.cfg)
  with self.assertRaises(ValueError):create_manifest(self.path,'windows',0,self.url,self.seed,self.cfg)
if __name__=='__main__':unittest.main()

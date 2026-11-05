import base64,hashlib,json,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives.serialization import Encoding,PublicFormat
from signed_updates import verify_manifest,download_verified,UpdateError,_RestrictedRedirect
class Response:
 status=200
 def __init__(self,data):self.data=data
 def read(self,n):x=self.data[:n];self.data=self.data[n:];return x
 def __enter__(self):return self
 def __exit__(self,*args):pass
class Opener:
 def __init__(self,data):self.data=data
 def open(self,*a,**k):return Response(self.data)
class Tests(unittest.TestCase):
 def setUp(self):
  self.private=Ed25519PrivateKey.generate();self.public=self.private.public_key().public_bytes(Encoding.Raw,PublicFormat.Raw)
  self.allowed={('downloads.example.test',443)};self.content=b'package';self.data={'schema_version':1,'product':'akg-retro-games','platform':'windows','version_code':2,'size_bytes':len(self.content),'sha256':hashlib.sha256(self.content).hexdigest(),'url':'https://downloads.example.test/update.exe'}
 def envelope(self,data=None):
  payload=json.dumps(self.data if data is None else data,separators=(',',':')).encode();return json.dumps({'payload':base64.b64encode(payload).decode(),'signature':base64.b64encode(self.private.sign(payload)).decode()}).encode()
 def verify(self,env=None,**kw):return verify_manifest(env or self.envelope(),kw.get('public',self.public),'akg-retro-games',kw.get('platform','windows'),kw.get('current',1),self.allowed)
 def test_signature_identity_and_version(self):
  self.assertEqual(self.verify()['version_code'],2)
  with self.assertRaises(UpdateError):self.verify(public=bytes(32))
  with self.assertRaises(UpdateError):self.verify(platform='linux')
  with self.assertRaises(UpdateError):self.verify(current=2)
  with self.assertRaises(UpdateError):self.verify(self.envelope().replace(b'payload',b'payloax'))
 def test_reject_unsafe_destinations(self):
  for url in ['http://downloads.example.test/x','https://evil.example/x','https://u:p@downloads.example.test/x','https://downloads.example.test/x#fragment','https://downloads.example.test:444/x']:
   d=dict(self.data,url=url)
   with self.assertRaises(UpdateError):self.verify(self.envelope(d))
 def test_reject_bad_shape_and_duplicate_keys(self):
  for d in [dict(self.data,size_bytes=True),dict(self.data,version_code=True),dict(self.data,sha256='z'*64),dict(self.data,extra='x')]:
   with self.assertRaises(UpdateError):self.verify(self.envelope(d))
  with self.assertRaises(UpdateError):self.verify(b'{"payload":"x","payload":"x","signature":"x"}')
 def test_atomic_good_and_bad_download(self):
  manifest=self.verify()
  with tempfile.TemporaryDirectory() as td:
   path=Path(td)/'package';path.write_bytes(b'existing')
   with patch('urllib.request.build_opener',return_value=Opener(b'wrong')):
    with self.assertRaises(UpdateError):download_verified(manifest,path,self.allowed)
   self.assertEqual(path.read_bytes(),b'existing');self.assertFalse(list(path.parent.glob('*.part')))
   with patch('urllib.request.build_opener',return_value=Opener(self.content)):download_verified(manifest,path,self.allowed)
   self.assertEqual(path.read_bytes(),self.content)
 def test_reject_redirect_outside_origin(self):
  with self.assertRaises(UpdateError):_RestrictedRedirect(self.allowed).redirect_request(None,None,302,'',{},'https://evil.example/x')
if __name__=='__main__':unittest.main()

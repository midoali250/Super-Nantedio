"""Create authenticated update manifests from the actual platform release bytes.

The Ed25519 seed is supplied through the runner environment, never as an
argument or on disk. This helper signs metadata only; it does not publish,
install, or claim a release is production-ready.
"""
import argparse,base64,hashlib,json,os,urllib.parse
from pathlib import Path
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives.serialization import Encoding,PublicFormat

PRODUCT='akg-retro-games'
PLATFORMS={'android','windows','linux','macos'}
MAX_SIZE=2_000_000_000

def create_manifest(path,platform,version,url,seed,public_config):
 if platform not in PLATFORMS or type(version) is not int or version<1:raise ValueError('Invalid platform or version')
 if not isinstance(public_config,dict) or public_config.get('algorithm')!='Ed25519' or public_config.get('platform')!=platform:raise ValueError('Wrong platform verification key')
 try:
  private=Ed25519PrivateKey.from_private_bytes(base64.b64decode(seed,validate=True))
  public=base64.b64decode(public_config['public_key_base64'],validate=True)
 except Exception as e:raise ValueError('Invalid signing key') from e
 if private.public_key().public_bytes(Encoding.Raw,PublicFormat.Raw)!=public:raise ValueError('Signing key does not match pinned public key')
 file=Path(path)
 if not file.is_file() or file.is_symlink():raise ValueError('Release asset must be a regular file')
 u=urllib.parse.urlsplit(url);parts=u.path.split('/')
 if (u.scheme!='https' or u.hostname!='github.com' or u.username or u.password or u.port not in (None,443) or u.query or u.fragment or len(parts)!=7 or parts[1]!='midoali250' or parts[2]!='akg-retro-games-'+platform or parts[3:5]!=['releases','download'] or not parts[5] or urllib.parse.unquote(parts[6])!=file.name):raise ValueError('Release asset URL does not match platform and file')
 digest=hashlib.sha256();size=0
 with file.open('rb') as f:
  while True:
   data=f.read(1024*1024)
   if not data:break
   size+=len(data)
   if size>MAX_SIZE:raise ValueError('Release asset too large')
   digest.update(data)
 if size==0:raise ValueError('Empty release asset')
 obj={'schema_version':1,'product':PRODUCT,'platform':platform,'version_code':version,'size_bytes':size,'sha256':digest.hexdigest(),'url':url}
 payload=json.dumps(obj,ensure_ascii=True,separators=(',',':')).encode('utf8')
 return json.dumps({'payload':base64.b64encode(payload).decode(),'signature':base64.b64encode(private.sign(payload)).decode()},separators=(',',':')).encode('utf8')

def main():
 p=argparse.ArgumentParser();p.add_argument('--asset',required=True);p.add_argument('--platform',required=True,choices=sorted(PLATFORMS));p.add_argument('--version-code',type=int,required=True);p.add_argument('--url',required=True);p.add_argument('--public-key',required=True);p.add_argument('--output',required=True);a=p.parse_args()
 seed=os.environ.get('AKG_UPDATE_SIGNING_SEED','')
 config=json.loads(Path(a.public_key).read_text(encoding='utf8'))
 env=create_manifest(a.asset,a.platform,a.version_code,a.url,seed,config);Path(a.output).write_bytes(env)
 print('Signed update manifest generated for',a.platform,'version',a.version_code)
if __name__=='__main__':main()

"""Sign the APK on a GitHub runner using the sealed repository secret."""
import base64,hashlib,json,os,re,shutil,subprocess,tempfile
from pathlib import Path
root=Path(__file__).resolve().parent.parent;android=root/'android';config=json.loads(os.environ['PIXEL_ANDROID_RELEASE_SIGNING_JSON']);expected=json.loads((root/'android-certificate.json').read_text())['certificate_sha256']
if config['alias']!='pixelflux-release' or not re.fullmatch('[0-9a-f]{64}',expected):raise ValueError('Invalid signing identity')
apksigner=Path(os.environ['ANDROID_HOME'])/'build-tools/35.0.0/apksigner'
with tempfile.TemporaryDirectory(prefix='pixelflux-signing-',dir=os.environ.get('RUNNER_TEMP')) as td:
 key=Path(td)/'release.p12';key.write_bytes(base64.b64decode(config['keystore_base64'],validate=True));env=dict(os.environ);env.pop('PIXEL_ANDROID_RELEASE_SIGNING_JSON',None);env.update({'PIXEL_RELEASE_KEYSTORE':str(key),'PIXEL_RELEASE_STORE_PASSWORD':config['password'],'PIXEL_RELEASE_KEY_ALIAS':config['alias'],'PIXEL_RELEASE_KEY_PASSWORD':config['password']})
 try:
  subprocess.run(['./gradlew',':app:assembleRelease','--no-daemon'],cwd=android,env=env,check=True,timeout=900)
  apk=android/'app/build/outputs/apk/release/app-release.apk';output=subprocess.check_output([str(apksigner),'verify','--verbose','--print-certs',str(apk)],text=True,stderr=subprocess.STDOUT,timeout=60)
  match=re.search(r'Signer #1 certificate SHA-256 digest:\s*([0-9a-fA-F]+)',output)
  if not match or match.group(1).lower()!=expected:raise RuntimeError('Android release certificate mismatch')
  dest=root/'PixelFlux-Android-signed.apk';shutil.copy2(apk,dest);print('PASS Android signed APK certificate',expected,'sha256',hashlib.sha256(dest.read_bytes()).hexdigest())
 finally:key.unlink(missing_ok=True)

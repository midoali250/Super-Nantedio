import hashlib,json,urllib.request
from pathlib import Path
root=Path(__file__).resolve().parent.parent;record=json.loads((root/'game.json').read_text());dest=root/'roms'/f"{record['source_id']}.nes";dest.parent.mkdir(parents=True,exist_ok=True)
if dest.is_file():data=dest.read_bytes()
else:
 url='https://drive.google.com/uc?export=download&id='+record['source_id']
 with urllib.request.urlopen(urllib.request.Request(url,headers={'User-Agent':'PixelFlux/1'}),timeout=90) as f:data=f.read(10_000_001)
if len(data)>10_000_000 or not data.startswith(b'NES\x1a') or hashlib.sha256(data).hexdigest()!=record['rom_sha256']:raise SystemExit('ROM identity validation failed')
dest.write_bytes(data);out=root/'android/app/src/main/assets/roms';out.mkdir(parents=True,exist_ok=True);(out/dest.name).write_bytes(data)
print('Verified exact PixelFlux multicart ROM:',record['rom_sha256'])

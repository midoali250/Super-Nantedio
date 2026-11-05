import hashlib,json,sys,urllib.request,os
from pathlib import Path
sys.path.insert(0,str(Path('engine/desktop').resolve()))
from libretro_host import LibretroHost
from game_session import frame_surface
import pygame
out=Path('pixelflux-audit-output');out.mkdir(exist_ok=True)
u='https://drive.google.com/uc?export=download&id=111kGbhhbliijXvVSg0gkwB2XYOwHdaPL'
with urllib.request.urlopen(urllib.request.Request(u,headers={'User-Agent':'PixelFlux-Audit/1'}),timeout=90) as f:raw=f.read(10_000_001)
if len(raw)>10_000_000 or hashlib.md5(raw).hexdigest()!='3e2ffd3ad12644dbb2fec0bfb85f9990' or not raw.startswith(b'NES\x1a'):raise SystemExit('ROM hash/header verification failed')
rom=Path('pixelflux-audit-rom.nes');rom.write_bytes(raw);h=raw[:16];mapper=(h[6]>>4)|(h[7]&0xf0);result={'size':len(raw),'sha256':hashlib.sha256(raw).hexdigest(),'md5':hashlib.md5(raw).hexdigest(),'ines_header':h.hex(),'mapper':mapper,'screens':[]}
print('ROM SIZE',len(raw),'SHA256',result['sha256'],'MAPPER',mapper,flush=True)
pygame.init();pygame.display.set_mode((640,480))
with LibretroHost('core/fceumm_libretro.so',rom) as host:
 result['core']=host.system_name;result['fps']=host.fps;result['audio_rate']=host.sample_rate
 for frame in range(1800):
  host.buttons={3} if 1200<=frame<1204 else set()
  host.run_frame();host.drain_audio()
  if frame in (59,299,899,1199,1499,1799):
   image=frame_surface(host)
   if image:
    dest=out/('frame-%04d.png'%(frame+1));pygame.image.save(image,dest);result['screens'].append(str(dest));print('SCREEN',dest,host.width,host.height,flush=True)
 result['frames']=host.frames;result['audio_samples']=host.audio_samples
 if not result['screens'] or host.audio_samples==0:raise RuntimeError('Core did not produce video and audio')
 (out/'audit.json').write_text(json.dumps(result,indent=2)+'\n')
 print('PASS ROM launched with video, audio and scripted Start after menu; see screenshots',flush=True)
pygame.quit()

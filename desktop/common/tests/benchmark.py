import os,sys,time,tempfile,statistics,json
from pathlib import Path
os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import pygame,app
pygame.init();pygame.display.set_mode((1,1));core=app.Core();surface=pygame.Surface((256,240),0,16,(0xf800,0x07e0,0x001f,0))
for _ in range(120):core.frame(0,0)

def summary(v):
 v=sorted(v);return {'avg_ms':round(statistics.mean(v),3),'p95_ms':round(v[int((len(v)-1)*.95)],3),'max_ms':round(max(v),3)}
frame=[];scaling=[];snap=[];disk=[]
with tempfile.TemporaryDirectory() as tmp:
 for i in range(120):
  t=time.perf_counter();core.frame(0,0);surface.get_buffer().write(core.framebuffer());frame.append((time.perf_counter()-t)*1000)
  t=time.perf_counter();pygame.transform.scale(surface,(3840,2160));scaling.append((time.perf_counter()-t)*1000)
  if i%10==0:
   t=time.perf_counter();data=app.snapshot(core);snap.append((time.perf_counter()-t)*1000)
   t=time.perf_counter();app.write_atomic(Path(tmp)/'save.state',data);disk.append((time.perf_counter()-t)*1000)
print('PERFORMANCE_MS',json.dumps({'native_frame':summary(frame),'scale_4k_allocate':summary(scaling),'serialize':summary(snap),'synchronous_atomic_disk_write':summary(disk)}))
assert all(len(x)>0 for x in (frame,scaling,snap,disk))
pygame.quit()

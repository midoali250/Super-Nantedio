"""Remove corner-connected near-white background without cropping icon artwork."""
from collections import deque
from pathlib import Path
from PIL import Image
import sys
p=Path(sys.argv[1]);im=Image.open(p).convert('RGBA');w,h=im.size;pix=im.load();todo=deque([(0,0),(w-1,0),(0,h-1),(w-1,h-1)]);seen=set()
while todo:
    x,y=todo.popleft()
    if (x,y) in seen or x<0 or y<0 or x>=w or y>=h:continue
    seen.add((x,y));r,g,b,a=pix[x,y]
    if r<242 or g<242 or b<242:continue
    pix[x,y]=(r,g,b,0)
    todo.extend(((x-1,y),(x+1,y),(x,y-1),(x,y+1)))
im.save(p)
if len(sys.argv)>2:
    target=Path(sys.argv[2])
    if target.suffix.lower()=='.ico':im.save(target,format='ICO',sizes=[(256,256),(128,128),(64,64),(48,48),(32,32),(16,16)])
    elif target.suffix.lower()=='.icns':im.save(target,format='ICNS')
    else:raise ValueError('unsupported icon format')

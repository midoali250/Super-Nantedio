from pathlib import Path
from PIL import Image
root=Path(__file__).resolve().parent.parent
im=Image.open(root/'desktop/assets/icon.png').convert('RGBA')
for density,px in [('mdpi',48),('hdpi',72),('xhdpi',96),('xxhdpi',144),('xxxhdpi',192)]:
 p=root/'android/app/src/main/res'/('mipmap-'+density);p.mkdir(parents=True,exist_ok=True);im.resize((px,px),Image.Resampling.LANCZOS).save(p/'ic_launcher.png')
im.save(root/'desktop/assets/icon.ico',sizes=[(16,16),(32,32),(48,48),(64,64),(128,128),(256,256)])
try:im.resize((1024,1024)).save(root/'desktop/assets/icon.icns')
except Exception as e:print('ICNS unavailable:',e)

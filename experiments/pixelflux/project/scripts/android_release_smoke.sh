#!/usr/bin/env bash
set -euo pipefail
if [ -f baseline/PixelFlux-Android-signed.apk ]; then
  adb install baseline/PixelFlux-Android-signed.apk
  adb install -r PixelFlux-Android-signed.apk
  echo 'PASS same-certificate v1.2 to v1.3 install'
else
  adb install PixelFlux-Android-signed.apk
fi
adb shell wm size 640x1280
adb logcat -c
adb shell am start -n com.pixelflux.app/com.bitvaultengine.retrocollection.MainActivity
python3 - <<'PY'
import subprocess,time,re,xml.etree.ElementTree as ET
from io import BytesIO
from PIL import Image,ImageChops

def adb(*a):return subprocess.check_output(['adb',*a],timeout=30)
def find(text):
 for i in range(20):
  try:
   adb('shell','uiautomator','dump','/sdcard/pixel-final-ui.xml');root=ET.fromstring(adb('exec-out','cat','/sdcard/pixel-final-ui.xml'))
   n=next((n for n in root.iter('node') if n.get('text','').casefold()==text.casefold()),None)
   if n is not None:return n
  except Exception:pass
  time.sleep(.5)
 raise RuntimeError('UI not found: '+text)
def tap(n):
 m=re.fullmatch(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]',n.get('bounds',''));assert m
 x1,y1,x2,y2=map(int,m.groups());adb('shell','input','tap',str((x1+x2)//2),str((y1+y2)//2))
def log():return adb('logcat','-d').decode('utf8','replace')
def waitlog(text):
 for i in range(30):
  if text in log():return
  time.sleep(1)
 raise RuntimeError('Log message missing: '+text)
waitlog('PLAYER_READY');find('PixelFlux');find('Settings');find('About');find('Reset')
adb('shell','uiautomator','dump','/sdcard/pixel-final-ui.xml');xml=adb('exec-out','cat','/sdcard/pixel-final-ui.xml').decode()
if re.search(r'text="[^"]*\bPlay\b',xml,re.I):raise RuntimeError('Unexpected Play button on home screen')
tap(find('Reset'));find('Reset entire app?');tap(find('Cancel'));tap(find('About'));find('About PixelFlux');tap(find('Close'))
time.sleep(2);first=Image.open(BytesIO(adb('exec-out','screencap','-p'))).convert('RGB')
green=sum(1 for r,g,b in first.crop((300,0,1280,640)).getdata() if g>100 and g>r*1.3 and g>b*1.2)
if green<100:raise RuntimeError('Live green multicart menu not visible inside home screen')
# The native surface occupies the right 77 percent of the landscape screen.
adb('shell','input','swipe','860','595','860','595','250');time.sleep(2)
second=Image.open(BytesIO(adb('exec-out','screencap','-p'))).convert('RGB')
if not ImageChops.difference(first,second).getbbox():raise RuntimeError('No visible change after Start')
waitlog('GAME_FULLSCREEN')
adb('shell','uiautomator','dump','/sdcard/pixel-full-ui.xml');fullxml=adb('exec-out','cat','/sdcard/pixel-full-ui.xml').decode()
if 'text="PixelFlux"' in fullxml:raise RuntimeError('Sidebar remained visible after selecting game')
# Fullscreen game settings is drawn in the top center of the native surface.
adb('shell','input','tap','640','45');tap(find('Save stage / position'));tap(find('Slot 1'));waitlog('Saved slot 1')
adb('shell','input','tap','640','45');tap(find('Load stage / position'));tap(find('Slot 1'));waitlog('Loaded slot 1')
adb('shell','input','tap','640','45');tap(find('Back to cartridge menu'));find('Return to cartridge menu?');tap(find('Return to menu'));waitlog('CORE_RESET');find('PixelFlux')
print('PASS signed Android: embedded menu, full-screen game on Start, return to menu, About, reset cancel, save and restore')
PY

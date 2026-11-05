#!/usr/bin/env bash
set -euo pipefail
adb install PixelFlux-Android-signed.apk
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
# The native surface occupies the right 77 percent of the landscape screen.
adb('shell','input','swipe','860','595','860','595','250');time.sleep(2)
second=Image.open(BytesIO(adb('exec-out','screencap','-p'))).convert('RGB')
if not ImageChops.difference(first,second).getbbox():raise RuntimeError('No visible change after Start')
tap(find('Settings'));tap(find('Save stage / position'));tap(find('Slot 1'));waitlog('Saved slot 1')
tap(find('Settings'));tap(find('Load stage / position'));tap(find('Slot 1'));waitlog('Loaded slot 1')
print('PASS signed Android: auto-open embedded menu, no Play button, About, reset cancel, Start, manual save and restore')
PY

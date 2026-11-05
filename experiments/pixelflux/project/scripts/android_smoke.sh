#!/usr/bin/env bash
set -euo pipefail
APK=$(find android/app/build/outputs/apk/debug -name '*.apk' -type f -print -quit);test -n "$APK"
PKG=com.pixelflux.app
ACT=com.bitvaultengine.retrocollection.MainActivity
adb install "$APK"
adb shell wm size 640x1280
adb logcat -c
adb shell am start -n "$PKG/$ACT" --ez pixel_ci_smoke true
for i in $(seq 1 60); do if adb logcat -d -s AKG_ANDROID:I | grep -q PLAYER_READY;then break;fi;sleep 2;done
adb logcat -d -s AKG_ANDROID:I | grep -q PLAYER_READY
adb shell input swipe 50 270 115 270 250
for XY in '1152 448' '1024 512' '1024 384' '896 448';do read -r X Y <<< "$XY";adb shell input swipe "$X" "$Y" "$X" "$Y" 220;done
for i in $(seq 1 90); do if adb logcat -d -s AKG_ANDROID_SMOKE:I | grep -q PASS;then break;fi;sleep 2;done
adb logcat -d -s AKG_ANDROID_SMOKE:I | grep PASS
for FACE in 1 2 4 8;do adb logcat -d -s AKG_ANDROID_TOUCH:I | grep -q "faces=$FACE";done
adb logcat -d -s AKG_ANDROID_INPUT:I | tr -d '\r' | grep -q 'core=128$'
echo 'PASS PixelFlux Android four face controls and free joystick reached core'
adb shell am force-stop "$PKG";adb shell am start -n "$PKG/$ACT"
python3 - <<'PY'
import subprocess,time,re,xml.etree.ElementTree as ET

def adb(*a):return subprocess.check_output(['adb',*a],timeout=30).decode('utf8','replace')
def find(text):
 for i in range(15):
  try:
   adb('shell','uiautomator','dump','/sdcard/pixel-ui.xml');root=ET.fromstring(adb('exec-out','cat','/sdcard/pixel-ui.xml'))
   node=next((n for n in root.iter('node') if n.get('text','').casefold()==text.casefold()),None)
   if node is not None:return node
  except Exception:pass
  time.sleep(.5)
 raise RuntimeError('UI not found: '+text)
def tap(n):
 m=re.fullmatch(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]',n.get('bounds',''));assert m
 x1,y1,x2,y2=map(int,m.groups());adb('shell','input','tap',str((x1+x2)//2),str((y1+y2)//2))
find('PixelFlux');find('Settings');find('About');tap(find('Settings'));find('Move joystick and four buttons');find('Button mapping: classic games');find('Reset entire app');tap(find('Close'))
tap(find('About'));find('About PixelFlux')
adb('shell','uiautomator','dump','/sdcard/pixel-about.xml');xml=adb('exec-out','cat','/sdcard/pixel-about.xml')
if 'Ahmed Kamal Elgandy' not in xml:raise RuntimeError('Attribution missing')
print('PASS PixelFlux Android settings, reset option and About attribution')
PY

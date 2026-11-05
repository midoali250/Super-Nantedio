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
echo "PASS debug game input smoke"
adb shell am force-stop "$PKG";adb logcat -c;adb shell am start -n "$PKG/$ACT"
for i in $(seq 1 40); do if adb logcat -d -s AKG_ANDROID:I | grep -q PLAYER_READY;then break;fi;sleep 2;done
adb logcat -d -s AKG_ANDROID:I | grep -q PLAYER_READY
python3 - <<'PY'
import subprocess,time,xml.etree.ElementTree as ET,re
for _ in range(15):
 try:
  subprocess.run(['adb','shell','uiautomator','dump','/sdcard/pixel-home.xml'],check=True,stdout=subprocess.DEVNULL,timeout=30)
  xml=subprocess.check_output(['adb','exec-out','cat','/sdcard/pixel-home.xml'],timeout=20).decode();root=ET.fromstring(xml)
  texts=[n.get('text','') for n in root.iter('node')]
  if 'PixelFlux' in texts and 'Settings' in texts and 'About' in texts:
   assert not any(re.search(r'\bplay\b',x,re.I) for x in texts),texts
   print('PASS Android launch automatically opens embedded cartridge without a Play button');break
 except Exception:pass
 time.sleep(1)
else:raise RuntimeError('Embedded home screen failed')
PY

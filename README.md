# BitVaultEngine - NES Emulator for Android

تطبيق أندرويد لتشغيل ألعاب NES (نينتندو إنترتينمنت سيستم) مع أداة تفكيك لملفات الرويم (ROM) وسلسلة بناء آلية عبر GitHub Actions.

## محتويات المشروع

| المسار | الوصف |
|--------|-------|
| `android/` | تطبيق أندرويد operates عبر WebView + محاكي jsnes |
| `android/app/src/main/assets/emulator.html` | واجهة المحاكي والتحكمات على الشاشة |
| `android/app/src/main/assets/*.nes` | لعبة罗马 مدمجة (Super Mario Bros. + Duck Hunt) |
| `tools/nes_disassembler.py` | أداة بايثون لتفكيك ملفات NES ROM إلى 6502 Assembly |
| `.github/workflows/android-ci.yml` | سير عمل GitHub Actions لبناء APK وتشغيل الاختبارات |
| `roms/` | مجلد ملفات الرويم |

## كيفية البناء محلياً

### المتطلبات
- Java JDK 17 أو أعلى
- Android SDK (بأدوات البناء 34)
- Python 3 (لأداة التفكيك)

### بناء APK
```bash
cd android
chmod +x gradlew
./gradlew assembleDebug
```
سيتم إخراج APK في:
```
android/app/build/outputs/apk/debug/app-debug.apk
```

### تشغيل أداة التفكيك
```bash
python3 tools/nes_disassembler.py "roms/Super Mario Bros. + Duck Hunt (E) [!].nes" --output tools/disassembly_output.txt
```

## سير العمل في GitHub Actions

عند كل push أو pull request إلى فرع `main`:
1. يتم إعداد JDK 17 و Android SDK
2. يتم بناء APK للتصحيح (Debug APK)
3. يتم تشغيل اختبارات الوحدة (Unit Tests)
4. يتم رفع APK كـ Artifact للتنزيل
5. يتم تفكيك روم NES وحفظ المخرجات
6. يتم التحقق من وجود ملفات الروم والـ APK

## التحكمات على الشاشة

| الزر | الوصف |
|------|-------|
| ▲ ◀ ▼ ▶ | اتجاهية (D-Pad) |
| A | زر A |
| B | زر B |
| SELECT | اختيار |
| START | بدء |

## ملخص ملف الروم المرفق

- **الملف:** `Super Mario Bros. + Duck Hunt + World Class Track Meet (U) (PRG0) [!].nes`
- **الحجم:** 196,624 بايت (192 KB)
- **النوع:** iNES ROM - 8x16k PRG, 8x8k CHR [H-mirror]
- **Mapper:** 1 (MMC1)

## الترخيص

هذا المشروع للأغراض التعليمية والتجريبية. ملفات الألعاب (ROMs) خاضعة لحقوق ملكية نينتندو الأصلية.


## Mario + Duck Hunt Android project

Source, controls, optional Mario cheats, and tests: [`games/nes-mario-duckhunt/`](games/nes-mario-duckhunt/). The separate `android/` directory contains the older WebView-based project. Download the published APK from [Releases](https://github.com/midoali250/bitvault-engine/releases).


## مركز معلومات التحديثات

راجع [`updates/`](updates/) لملفات إصدارات الألعاب وطريقة إضافة تحديث. هذا المجلد لا يضيف التحديث التلقائي للألعاب بمفرده.


## تجهيز المشاريع والاختبارات

- مشروع WebView القديم يستخدم مكتبة jsnes **2.1.0** المرفقة محليًا في
  `android/app/src/main/assets/vendor/jsnes/` مع ترخيصها، بدون تحميل المكتبة
  وقت التشغيل. المسار مبني على Gradle Wrapper 8.4؛ يلزم JDK 17 وAndroid SDK 34.
- هذا المشروع القديم مثال أولي: الصوت فيه غير مفعّل، ولم يُختبر على هاتف في
  هذا التحديث، وهو منفصل عن إصدار Mario + Duck Hunt المرفوع في Releases.
- مشروع Mario الأصلي في `games/nes-mario-duckhunt/` يضم FCEUmm ومكتبة صوت خاصة
  به؛ يتطلب JDK 17 وSDK 35 وNDK 27.0.12077973 وCMake 3.22.1 عند البناء.
- اختبارات GitHub: بناء المشروعين، محاكاة jsnes دون اتصال عبر Node، اختبارات
  Python للتفكيك، واختبارات الكنترول وذاكرة اللعبة للنواة المحلية. اختبارات
  النواة تتطلب Python 3 وPillow 11.3.0 وCMake ومترجم C.
- قبل إنشاء لعبة جديدة: انسخ قالب عميل التحديثات في `updates/client/android/`,
  وأضف ملف إصدار مستقل واحتفظ بمفتاح توقيع اللعبة في مكان آمن مع نسخة احتياطية.
- بناء APK لا يمنح حقوق توزيع ROM: تحقق من الترخيص وحق التوزيع لكل لعبة.


## Super Mario Bros. (World) للأندرويد

[مشروع اللعبة](games/super-mario-world/) — [تحميل إصدار 1.4](https://github.com/midoali250/bitvault-engine/releases/download/super-mario-world-v1.4/Super-Mario-Bros-World-1.4.apk).


## Mazinger Z (SNES) للأندرويد

[مشروع اللعبة](games/mazinger-z/) — أول لعبة **SNES** في المستودع.

[تحميل إصدار 1.1 (موقّع)](https://github.com/mosalah30688-gif/bitvault-engine/releases/download/mazinger-z-v1.1/Mazinger-Z-SNES-1.1.apk)
— حجمه 6.5 ميجا، محتاج أندرويد 8.0 أو أحدث (arm64-v8a أو armeabi-v7a).

الشنيس جهاز مختلف تماماً عن NES (معالج 65816 + معالج صوت SPC700 مستقل)،
فمحتاج نواة محاكي خاصة. المشروع بيتبني بنفس نمط ألعاب NES الموجودة:

- `app/src/main/cpp/snes_jni.c`: جسر JNI فوق واجهة libretro — بيغذّي الروم
  في `retro_load_game()`، ويسلّم الفيديو RGB565 والصوت ستيريو، ويترجم قناع
  أزرار الديد باد.
- `app/src/main/cpp/snes9x2010-src/`: نواة Snes9x 2010 (انظر التراخيص في
  `games/mazinger-z/THIRD_PARTY_NOTICES.md`).
- `app/src/main/java/com/midoali/snes/`: طبقة الأندرويد — النشاط، خيط المحاكاة،
  سطح العرض، ولوحة المفاتيح (عصا + X/Y/A/B + L/R).
- `tools/host/`: مشغّل على سطح المكتب بيشغّل **نفس** كود C عشان تختبر النواة
  من غير موبايل.
- `tools/vpad/`: اختبار لطبقة التحكم على JVM عادي.

اختبار النواة من غير جهاز:

```bash
cd games/mazinger-z
cmake -S tools/host -B tools/host/build && cmake --build tools/host/build -j 2
python3 tools/host/test_boot.py
```

الـ build على أندرويد يحتاج JDK 17 وSDK 35 وNDK 27.0.12077973 وCMake 3.22.1.
نواة Snes9x بترخيص غير تجاري، فالمشروع ده للاستخدام الشخصي غير التجاري؛
لو احتجت توزيع تجاري، بدّل النواة بـ bsnes (GPLv3) — جسر JNI بيتكلم مع
واجهة libretro بس، فما فيوش حاجة تانية هتتغير.



## The Mask (SNES) للأندرويد وسطح المكتب (Windows / Linux / macOS)

[مشروع الأندرويد](games/the-mask/) — [مشروع سطح المكتب](desktop/the-mask/)

### المزايا المدمجة (الإصدار 1.0 / 1.0.0)
- **قائمة أكواد الغش (Cheat Codes Menu)**: 6 أكواد غش مدمجة تعمل مباشرة على ذاكرة WRAM الخاصة باللعبة (`Infinite Health`, `Infinite Mask Power`, `Infinite Lives`, `Invincibility / Ghost`, `Moon Jump`, `Stage Select`).
- **عصاية تحكم حرة 360° في تطبيق الأندرويد (Free-Floating Analog Joystick)**: عصا افتراضية حرة الحركة بزاوية 360 درجة على النصف الأيسر من الشاشة تدعم الاتجاهات الثمانية والقطرية بسلاسة.
- **شاشة عريضة بعرض شاشة الموبايل (Full-Width Mobile Widescreen)**: عرض اللعبة افتراضيًا بعرض شاشة الهاتف بالكامل على الأندرويد مع خيار التبديل إلى `4:3` من القائمة.
- **زر `About` في القائمة**: يعرض نافذة التعريف بالتطبيق والمطور (**Ahmed Kamal Elgandy**).

| النظام | الحزمة | الحجم | SHA-256 | ملف بصمة التحديثات | أرشيف الإصدارات |
| --- | --- | --- | --- | --- | --- |
| **Android APK** | [The-Mask-SNES-1.0.apk](https://github.com/midoali250/bitvault-engine/releases/download/the-mask-v1.0/The-Mask-SNES-1.0.apk) | `7,606,150 B` | `a5985fa0410165269d3d263b1499731cd357beb6200979ce3e7fba2d9a368351` | [`updates/games/the-mask.json`](updates/games/the-mask.json) | [`RELEASE-ARCHIVE/Android/The-Mask/1.0/`](RELEASE-ARCHIVE/Android/The-Mask/) |
| **Windows x64 Portable EXE** | [The-Mask-Windows-x64.exe](https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-Windows-x64.exe) | `18,716,790 B` | `0fae178bc05d23a95a7f9322e836fd1f95b3e1f43357ce5f03a9bbca0e7c547c` | [`updates/desktop/the-mask.json`](updates/desktop/the-mask.json) | [`RELEASE-ARCHIVE/Windows/The-Mask/1.0.0/`](RELEASE-ARCHIVE/Windows/The-Mask/) |
| **Linux x86_64 AppImage** | [The-Mask-Linux-x86_64.AppImage](https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-Linux-x86_64.AppImage) | `29,067,768 B` | `d5f64e453600008eaae10162b9d2495f9d941ea5a8488205578103ccec4b3170` | [`updates/desktop/the-mask.json`](updates/desktop/the-mask.json) | [`RELEASE-ARCHIVE/Linux/The-Mask/1.0.0/`](RELEASE-ARCHIVE/Linux/The-Mask/) |
| **macOS Apple Silicon (App ZIP)** | [The-Mask-macOS-arm64.zip](https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-macOS-arm64.zip) | `18,510,240 B` | `c1e50fc9aa1a12d5664446a37b4c32a71db2d31c9fc658e1eef8b70564283046` | [`updates/desktop/the-mask.json`](updates/desktop/the-mask.json) | [`RELEASE-ARCHIVE/macOS/The-Mask/1.0.0/`](RELEASE-ARCHIVE/macOS/The-Mask/) |


## رعاة البقر — Sunset Riders (Sega Genesis) للأندرويد وسطح المكتب (Windows / Linux / macOS)

[مشروع الأندرويد](games/sunset-riders/) — [مشروع سطح المكتب](desktop/sunset-riders/)

### المزايا المدمجة (الإصدار 1.0 / 1.0.0)
- **جودة صورة فائقة True HD (2x Scale2x + De-Dither + HD Color LUT + GPU Filter)**: تكبير فوري بضعف الدقة (`640×448` / `512×448`) مع إزالة التشرشر وتنقية ألوان Sega Genesis VDP وتسريع العتاد (`lockHardwareCanvas` + `RGB_565` بدون نسخ في الجافا).
- **أداء سريع جدًا (60 إطار/ثانية) وصوت ستيريو نقي**: ضبط نواة `Genesis-Plus-GX` (`YM2612 Enhanced` بدون استنزاف مرشحات التردد الفائق) مع تزامن صوتي سلس على الأندرويد وسطح المكتب.
- **زر إعادة تشغيل اللعبة (`Reset Game` / `🔄 ريست`)**: متاح مباشرة في شريط التحكم العلوي وقائمة الإعدادات على الأندرويد، وفي القائمة الرئيسية أو اختصار `F5` على سطح المكتب (`Windows` / `Linux` / `macOS`).
- **عصاية تحكم حرة 360° وشاشة عريضة بعرض الموبايل** + **قسم `About`** باسم **Ahmed Kamal Elgandy**.

| النظام | الحزمة | ملف بصمة التحديثات | أرشيف الإصدارات |
| --- | --- | --- | --- |
| **Android APK** | [Sunset-Riders-1.0.apk](https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-v1.0/Sunset-Riders-1.0.apk) | [`updates/games/sunset-riders.json`](updates/games/sunset-riders.json) | [`RELEASE-ARCHIVE/Android/Sunset-Riders/1.0/`](RELEASE-ARCHIVE/Android/Sunset-Riders/1.0/) |
| **Windows x64 Portable EXE** | [Sunset-Riders-Windows-x64.exe](https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-Windows-x64.exe) | [`updates/desktop/sunset-riders.json`](updates/desktop/sunset-riders.json) | [`RELEASE-ARCHIVE/Windows/Sunset-Riders/1.0.0/`](RELEASE-ARCHIVE/Windows/Sunset-Riders/1.0.0/) |
| **Linux x86_64 AppImage** | [Sunset-Riders-Linux-x86_64.AppImage](https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-Linux-x86_64.AppImage) | [`updates/desktop/sunset-riders.json`](updates/desktop/sunset-riders.json) | [`RELEASE-ARCHIVE/Linux/Sunset-Riders/1.0.0/`](RELEASE-ARCHIVE/Linux/Sunset-Riders/1.0.0/) |
| **macOS Apple Silicon (App ZIP)** | [Sunset-Riders-macOS-arm64.zip](https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-macOS-arm64.zip) | [`updates/desktop/sunset-riders.json`](updates/desktop/sunset-riders.json) | [`RELEASE-ARCHIVE/macOS/Sunset-Riders/1.0.0/`](RELEASE-ARCHIVE/macOS/Sunset-Riders/1.0.0/) |


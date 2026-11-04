# bitvaultengine - NES Emulator for Android

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
python3 tools/nes_disassembler.py roms/*.nes --output tools/disassembly_output.txt --summary
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
- **المaber:** 0 (NROM)

## الترخيص

هذا المشروع للأغراض التعليمية والتجريبية. ملفات الألعاب (ROMs) خاضعة لحقوق ملكية نينتندو الأصلية.


## Mario + Duck Hunt Android project

Source, controls, optional Mario cheats, and tests: [`games/nes-mario-duckhunt/`](games/nes-mario-duckhunt/). The existing `android/` project is unchanged. Download the published APK from [Releases](https://github.com/midoali250/bitvault-engine/releases).


## مركز معلومات التحديثات

راجع [`updates/`](updates/) لملفات إصدارات الألعاب وطريقة إضافة تحديث. هذا المجلد لا يضيف التحديث التلقائي للألعاب بمفرده.

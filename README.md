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

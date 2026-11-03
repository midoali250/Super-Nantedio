# bitvaultengine — no obfuscation of the JS bridge.
-keep class com.bitvaultengine.nes.** { *; }
-keepclassmembers class com.bitvaultengine.nes.MainActivity$Bridge {
    @android.webkit.JavascriptInterface <methods>;
}

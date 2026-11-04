plugins { id("com.android.application") }
android {
    namespace = "com.bitvaultengine.updateexample"
    compileSdk = 35
    defaultConfig {
        applicationId = "com.bitvaultengine.updateexample"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }
    sourceSets.getByName("main").java.srcDir("../../src/main/java")
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

plugins {
    id("com.android.application")
}

import org.gradle.api.GradleException

// Release signing is opt-in via environment variables; no secrets in the repo.
// Each game keeps its own keystore, so the variable names are game specific.
val signingNames = listOf("SNES_KEYSTORE_PATH", "SNES_KEYSTORE_PASSWORD", "SNES_KEY_ALIAS", "SNES_KEY_PASSWORD")
val signingEnv = signingNames.associateWith { providers.environmentVariable(it).orNull.orEmpty() }
val signingRequested = signingEnv.values.any { it.isNotBlank() }
val signingConfigured = signingEnv.values.all { it.isNotBlank() }
if (signingRequested && !signingConfigured) {
    val missing = signingEnv.filterValues { it.isBlank() }.keys
    throw GradleException("Incomplete release signing configuration. Missing: ${missing.joinToString()}")
}

android {
    namespace = "com.midoali.snes"
    ndkVersion = "27.0.12077973"
    compileSdk = 35
    buildToolsVersion = "35.0.0"

    defaultConfig {
        applicationId = "com.midoali.snes.mazingerz"
        minSdk = 26
        targetSdk = 35
        versionCode = 2
        versionName = "1.1"
        ndk { abiFilters += listOf("arm64-v8a", "armeabi-v7a") }
        externalNativeBuild { cmake { arguments += "-DANDROID_STL=none" } }
    }

    sourceSets.getByName("main").java.srcDir("../../../updates/client/android/src/main/java")

    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }

    signingConfigs {
        if (signingConfigured) {
            create("release") {
                storeFile = file(signingEnv.getValue("SNES_KEYSTORE_PATH"))
                storePassword = signingEnv.getValue("SNES_KEYSTORE_PASSWORD")
                keyAlias = signingEnv.getValue("SNES_KEY_ALIAS")
                keyPassword = signingEnv.getValue("SNES_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            if (signingConfigured) signingConfig = signingConfigs.getByName("release")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    androidResources {
        noCompress += listOf("smc")
    }
}

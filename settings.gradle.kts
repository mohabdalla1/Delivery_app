pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localFile = java.io.File("local.properties")
        val androidLocalFile = java.io.File("android/local.properties")
        
        val sdkPath = when {
            localFile.exists() -> {
                localFile.inputStream().use { properties.load(it) }
                properties.getProperty("flutter.sdk")
            }
            androidLocalFile.exists() -> {
                androidLocalFile.inputStream().use { properties.load(it) }
                properties.getProperty("flutter.sdk")
            }
            else -> null
        }
        sdkPath ?: System.getenv("FLUTTER_ROOT")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.5.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

include(":app")
project(":app").projectDir = file("android/app")

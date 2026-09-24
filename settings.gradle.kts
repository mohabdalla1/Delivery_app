pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localPropertiesFile = file("local.properties")
        val androidLocalPropertiesFile = file("android/local.properties")
        
        when {
            localPropertiesFile.exists() -> {
                localPropertiesFile.inputStream().use { properties.load(it) }
                properties.getProperty("flutter.sdk")
            }
            androidLocalPropertiesFile.exists() -> {
                androidLocalPropertiesFile.inputStream().use { properties.load(it) }
                properties.getProperty("flutter.sdk")
            }
            else -> System.getenv("FLUTTER_ROOT")
        }
    }

    assert(flutterSdkPath != null) { "flutter.sdk not set in local.properties or FLUTTER_ROOT not set" }

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

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
    }
}

include(":app")

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localFile = java.io.File("local.properties")
        val androidLocalFile = java.io.File("android/local.properties")

        val sdkPathFromProp = when {
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

        sdkPathFromProp ?: System.getenv("FLUTTER_ROOT")
    }

    require(flutterSdkPath != null) { "Flutter SDK path not found. Ensure FLUTTER_ROOT is set or local.properties exists." }

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

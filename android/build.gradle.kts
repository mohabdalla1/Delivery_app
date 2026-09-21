plugins {
    // تحديث النسخة لتطابق الإصدار الموجود على الـ classpath (9.1.0) لتجنب التعارض
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val rootProjectDir = rootProject.buildDir.absoluteFile.parentFile
rootProject.extra["buildDir"] = "$rootProjectDir/build"

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}

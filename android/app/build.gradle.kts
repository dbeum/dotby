plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") 
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics") // Make sure this is included
}

android {
    namespace = "com.example.dotby1"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

   compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

   kotlinOptions {
    jvmTarget = "17" // Ensure this matches your project requirements
    freeCompilerArgs = listOf("-Xjvm-default=all")
}


    defaultConfig {
        applicationId = "com.example.dotby1"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM for version management
    implementation(platform("com.google.firebase:firebase-bom:33.10.0"))

    // Firebase dependencies (no version needed as BoM handles it)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-storage")
    implementation("com.google.firebase:firebase-messaging")
}
apply plugin: 'com.google.gms.google-services'

# Isar — keep generated code
-keep class io.isar.** { *; }
-keep class com.jaldrishti.** { *; }

# flutter_reactive_ble
-keep class com.signify.hue.flutterreactiveble.** { *; }

# audioplayers
-keep class xyz.luan.audioplayers.** { *; }

# Suppress warnings from optional deps
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**

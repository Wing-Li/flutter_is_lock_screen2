## [2.0.5] - 2026-06-12

- Improved the iOS lock-screen heuristic by combining protected data availability, protected data notifications, and screen brightness.
- Added Dart MethodChannel tests for `true`, `false`, `null`, platform exceptions, and missing plugin registration.
- Cleaned up analyzer hints in the example app and adjusted `.gitignore` for release packaging.
- Documented that iOS does not provide a stable public lock-screen state API, so iOS detection remains heuristic and should not be treated as a security source of truth.

## [2.0.4] - 2025-09-17

- Updated the .gitignore file, added Android build-related directories, and the pubspec.lock file.
- Updated compileSdkVersion from 34 to 35, Java version from 1.8 to 11, and Kotlin version from jdk7 to jdk8 in build.gradle.
- Updated example/android/build.gradle to remove jcenter() and update Kotlin version to 2.1.0.
- Added pluginManagement to settings.gradle to configure the Flutter SDK path.
- Added plugin declarations to app/build.gradle and updated compileSdkVersion and targetSdkVersion to 35.
- Updated dependency versions in pubspec.lock to ensure compatibility with the latest Dart and Flutter SDKs.
- Deleted the MainActivity.kt file to simplify the project structure.

## [2.0.3] - 2025-04-08

- removing name space from AndroidManifest.xml and moving it to build.gradle
- upgrading gradle version to 8.4
- removing the registerWith, it's no longer needed in the new FlutterPlugin

## [2.0.2] - 2025-02-24

* updating the min and the target sdk and the kotlin version

## [2.0.1] - 2023-7-23

* Update Android Gradle

## [2.0.0] - 2021-04-08

* Support null safety

* Clean up unused code and debug prints in iOS native part

* Update and and clean up example code

## [1.0.0] - 2020-07-16

* Initial release

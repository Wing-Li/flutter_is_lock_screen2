# is_lock_screen2

original link : [https://github.com/Hassanch15/flutter_is_lock_screen](https://github.com/Hassanch15/flutter_is_lock_screen)

***

Detects if device is locked. Useful for determining whether app entered background due to locking screen or leaving app.

## Usage

Import library and call the following method.

Note that this only works on physical device for iOS.

iOS does not provide a stable public API for directly reading whether the device is currently on the lock screen. On iOS, this plugin combines protected data availability, protected data notifications, and screen brightness as a heuristic. It is useful for common lock-screen background transitions, but it should not be treated as the only source of truth for security-sensitive lock state.

```dart
bool? result = await isLockScreen();
```

You will probably observe the AppLifecycleState with a WidgetsBindingObserver and call this when app is in background:

```dart
@override
void didChangeAppLifecycleState(AppLifecycleState state) async {
  super.didChangeAppLifecycleState(state);
  if (state == AppLifecycleState.inactive) {
    print('app inactive, is lock screen: ${await isLockScreen()}');
  } else if (state == AppLifecycleState.resumed) {
    print('app resumed');
  }
}
```

[See example app code for details](/example/lib/main.dart)

## Why this plugin?

An alternative to this plugin is [hardware_buttons](https://pub.dev/packages/hardware_buttons), which uses non-public API (`com.apple.springboard.lockcomplete`) on iOS to detect lock button usage and violates App Store requirements.

To circumvent this issue, this plugin detects whether iOS device is likely in lock screen by combining protected data availability, protected data notifications, and a brightness heuristic.

On android, this plugin uses `KeyguardManager` and `PowerManager` API to check if device is secured or display is off as suggested [in this gist](https://gist.github.com/Jeevuz/4ec01688083670b1f3f92af64e44c112). A similar flow was tested on iOS with `LocalAuthentication` and `UIApplication.shared.isProtectedDataAvailable` but failed due to long grace period of the system lock down. The flag always return true the moment screen is locked.

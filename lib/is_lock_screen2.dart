library is_lock_screen;

import 'package:flutter/services.dart';

const _channel = MethodChannel('is_lock_screen');

/// An exception thrown when the lock-screen state cannot be read.
class IsLockScreenException implements Exception {
  const IsLockScreenException(
    this.code,
    this.message, {
    this.details,
    this.cause,
  });

  final String code;
  final String message;
  final Object? details;
  final Object? cause;

  @override
  String toString() {
    final detailsText = details == null ? '' : ', details: $details';
    return 'IsLockScreenException($code): $message$detailsText';
  }
}

/// Returns whether the device is likely on the lock screen.
///
/// Returns `null` when the platform plugin is not registered, the platform
/// returns `null`, or the platform call fails. Use [isLockScreenOrThrow] when
/// callers need to distinguish these failure modes.
Future<bool?> isLockScreen() async {
  try {
    return await isLockScreenOrThrow();
  } catch (_) {
    return null;
  }
}

/// Returns whether the device is likely on the lock screen.
///
/// Throws [IsLockScreenException] when the plugin is missing, the platform
/// returns `null`, or the platform call fails.
Future<bool> isLockScreenOrThrow() async {
  try {
    final result = await _channel.invokeMethod<bool>('isLockScreen');
    if (result == null) {
      throw const IsLockScreenException(
        'null_result',
        'The platform returned null for isLockScreen.',
      );
    }
    return result;
  } on IsLockScreenException {
    rethrow;
  } on MissingPluginException catch (error) {
    throw IsLockScreenException(
      'missing_plugin',
      'The is_lock_screen2 plugin is not registered for this platform.',
      cause: error,
    );
  } on PlatformException catch (error) {
    throw IsLockScreenException(
      error.code,
      error.message ?? 'The platform failed to check the lock-screen state.',
      details: error.details,
      cause: error,
    );
  }
}

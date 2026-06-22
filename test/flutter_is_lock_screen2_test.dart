import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_lock_screen2/is_lock_screen2.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('is_lock_screen');
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('calls isLockScreen on the is_lock_screen channel and returns true', () async {
    final calls = <MethodCall>[];
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return true;
    });

    final result = await isLockScreen();

    expect(result, isTrue);
    expect(calls, hasLength(1));
    expect(calls.single.method, 'isLockScreen');
  });

  test('returns false when the platform returns false', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => false);

    final result = await isLockScreen();

    expect(result, isFalse);
  });

  test('returns null when the platform returns null', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => null);

    final result = await isLockScreen();

    expect(result, isNull);
  });

  test('returns null when the platform throws an exception', () async {
    messenger.setMockMethodCallHandler(channel, (_) async {
      throw PlatformException(code: 'NativeError', message: 'Native error');
    });

    final result = await isLockScreen();

    expect(result, isNull);
  });

  test('returns null when the plugin is not registered', () async {
    messenger.setMockMethodCallHandler(channel, null);

    final result = await isLockScreen();

    expect(result, isNull);
  });

  test('isLockScreenOrThrow returns the platform boolean result', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => true);

    final result = await isLockScreenOrThrow();

    expect(result, isTrue);
  });

  test('isLockScreenOrThrow throws when the platform returns null', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => null);

    expect(
      isLockScreenOrThrow,
      throwsA(
        isA<IsLockScreenException>()
            .having((error) => error.code, 'code', 'null_result')
            .having((error) => error.message, 'message', contains('null')),
      ),
    );
  });

  test('isLockScreenOrThrow wraps platform exceptions with details', () async {
    messenger.setMockMethodCallHandler(channel, (_) async {
      throw PlatformException(
        code: 'NativeError',
        message: 'Native error',
        details: {'reason': 'test'},
      );
    });

    expect(
      isLockScreenOrThrow,
      throwsA(
        isA<IsLockScreenException>()
            .having((error) => error.code, 'code', 'NativeError')
            .having((error) => error.message, 'message', 'Native error')
            .having((error) => error.details, 'details', {'reason': 'test'})
            .having((error) => error.cause, 'cause', isA<PlatformException>()),
      ),
    );
  });

  test('isLockScreenOrThrow throws a missing plugin exception wrapper', () async {
    messenger.setMockMethodCallHandler(channel, null);

    expect(
      isLockScreenOrThrow,
      throwsA(
        isA<IsLockScreenException>()
            .having((error) => error.code, 'code', 'missing_plugin')
            .having((error) => error.message, 'message', contains('registered'))
            .having((error) => error.cause, 'cause', isA<MissingPluginException>()),
      ),
    );
  });
}

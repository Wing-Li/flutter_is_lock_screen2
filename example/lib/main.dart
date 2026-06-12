import 'package:flutter/material.dart';
import 'package:is_lock_screen2/is_lock_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      log('app inactive, is lock screen: ${await isLockScreen()}');
    } else if (state == AppLifecycleState.resumed) {
      log('app resumed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text(
              'Test by changing app lifecycle (locking device / exiting app). \nResult will be print in console.'),
        ),
      ),
    );
  }

  void log(String msg) {
    debugPrint('============= ↓ start ↓================');
    debugPrint('= $msg ');
    debugPrint('============= ↓ end ↓================');
  }
}

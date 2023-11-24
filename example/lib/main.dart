import 'package:flutter/material.dart';
import 'dart:async';
import 'package:background_windows/background_windows.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _platformVersion = false;
  final _backgroundWindowsPlugin = BackgroundWindows();

  @override
  void initState() {
    super.initState();
    // ejecutar en intervalo de 1 segundo
    Timer.periodic(Duration(seconds: 1), (timer) async {
      // verificar si la app esta en segundo plano
      bool isAppInBackground =
          await _backgroundWindowsPlugin.isAppInBackground();
      // si la app esta en segundo plano
      if (isAppInBackground) {
        // ejecutar codigo
        print('App en segundo plano');
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    platformVersion = await _backgroundWindowsPlugin.isAppInBackground();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

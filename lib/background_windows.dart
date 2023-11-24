import 'dart:async';
import 'package:flutter/services.dart';

class BackgroundWindows {
  static const MethodChannel _channel = MethodChannel('background_windows');

  Future<bool> isAppInBackground() async {
    final bool isInBackground =
        await _channel.invokeMethod('isAppInBackground');
    return isInBackground;
  }
}

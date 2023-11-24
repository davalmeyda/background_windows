import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'background_windows_platform_interface.dart';

/// An implementation of [BackgroundWindowsPlatform] that uses method channels.
class MethodChannelBackgroundWindows extends BackgroundWindowsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('background_windows');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

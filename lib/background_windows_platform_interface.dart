import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'background_windows_method_channel.dart';

abstract class BackgroundWindowsPlatform extends PlatformInterface {
  /// Constructs a BackgroundWindowsPlatform.
  BackgroundWindowsPlatform() : super(token: _token);

  static final Object _token = Object();

  static BackgroundWindowsPlatform _instance = MethodChannelBackgroundWindows();

  /// The default instance of [BackgroundWindowsPlatform] to use.
  ///
  /// Defaults to [MethodChannelBackgroundWindows].
  static BackgroundWindowsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BackgroundWindowsPlatform] when
  /// they register themselves.
  static set instance(BackgroundWindowsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

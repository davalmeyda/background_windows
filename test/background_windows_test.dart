import 'package:flutter_test/flutter_test.dart';
import 'package:background_windows/background_windows.dart';
import 'package:background_windows/background_windows_platform_interface.dart';
import 'package:background_windows/background_windows_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBackgroundWindowsPlatform
    with MockPlatformInterfaceMixin
    implements BackgroundWindowsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BackgroundWindowsPlatform initialPlatform = BackgroundWindowsPlatform.instance;

  test('$MethodChannelBackgroundWindows is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBackgroundWindows>());
  });

  test('getPlatformVersion', () async {
    BackgroundWindows backgroundWindowsPlugin = BackgroundWindows();
    MockBackgroundWindowsPlatform fakePlatform = MockBackgroundWindowsPlatform();
    BackgroundWindowsPlatform.instance = fakePlatform;

    expect(await backgroundWindowsPlugin.getPlatformVersion(), '42');
  });
}

#include "include/background_windows/background_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "background_windows_plugin.h"

void BackgroundWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  background_windows::BackgroundWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

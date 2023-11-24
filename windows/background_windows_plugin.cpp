#include "background_windows_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace background_windows {

// static
void BackgroundWindowsPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "background_windows",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<BackgroundWindowsPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

BackgroundWindowsPlugin::BackgroundWindowsPlugin() {}

BackgroundWindowsPlugin::~BackgroundWindowsPlugin() {}

void BackgroundWindowsPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("isAppInBackground") == 0) {
    HWND hwnd = GetForegroundWindow();
    DWORD foreground_process_id;
    GetWindowThreadProcessId(hwnd, &foreground_process_id);
    DWORD current_process_id = GetCurrentProcessId();
    bool is_background = current_process_id != foreground_process_id;
    result->Success(flutter::EncodableValue(is_background));
  } else {
    result->NotImplemented();
  }
}

}  // namespace background_windows

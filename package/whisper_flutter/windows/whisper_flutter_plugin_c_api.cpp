#include "include/whisper_flutter/whisper_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "whisper_flutter_plugin.h"

void WhisperFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  whisper_flutter::WhisperFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

#ifndef FLUTTER_PLUGIN_WHISPER_FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_WHISPER_FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace whisper_flutter {

class WhisperFlutterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WhisperFlutterPlugin();

  virtual ~WhisperFlutterPlugin();

  // Disallow copy and assign.
  WhisperFlutterPlugin(const WhisperFlutterPlugin&) = delete;
  WhisperFlutterPlugin& operator=(const WhisperFlutterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace whisper_flutter

#endif  // FLUTTER_PLUGIN_WHISPER_FLUTTER_PLUGIN_H_

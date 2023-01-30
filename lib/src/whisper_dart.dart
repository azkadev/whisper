import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'whisper_dart_bindings.dart';

const String _libName = 'whisper_dart';

final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final WhisperDartBindings _bindings = WhisperDartBindings(_dylib);

class Whisper {
  WhisperResponse request({required WhisperRequest request}) {
    try {
      var res = _bindings.request(whisperRequest: request.toString());
      Map result = json.decode(res);
      return WhisperResponse(result);
    } catch (e) {
      return WhisperResponse({"@type": "error", "message": e.toString()});
    }
  }
}

class WhisperRequest {
  late Map rawData;
  WhisperRequest(this.rawData);

  factory WhisperRequest.fromWavFile({
    required File audio,
    required File model,
    bool isTranslate = false,
    int threads = 4,
    bool isVerbose = false,
    String language = "id",
    bool isSpecialTokens = false,
    bool isNoTimestamps = false,
  }) {
    return WhisperRequest({
      "@type": "getTextFromWavFile",
      "is_translate": isTranslate,
      "threads": threads,
      "is_verbose": isVerbose,
      "language": language,
      "is_special_tokens": isSpecialTokens,
      "is_no_timestamps": isNoTimestamps,
      "audio": audio.path,
      "model": model.path,
    });
  }

  Map toMap() {
    return (rawData);
  }

  Map toJson() {
    return (rawData);
  }

  @override
  String toString() {
    return json.encode(rawData);
  }
}

class WhisperResponse {
  late Map rawData;
  WhisperResponse(this.rawData);

  String? get specialType {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get text {
    try {
      if (rawData["text"] is String == false) {
        return null;
      }
      return rawData["text"] as String;
    } catch (e) {
      return null;
    }
  }

  Map toMap() {
    return (rawData);
  }

  Map toJson() {
    return (rawData);
  }

  @override
  String toString() {
    return json.encode(rawData);
  }
}

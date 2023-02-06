// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:ffi';
import 'package:universal_io/io.dart';
import 'package:ffi/ffi.dart';
import "scheme/scheme.dart";
import "whisper_request.dart";

export "whisper_audio_convert.dart";
export "whisper_request.dart";

// ignore: camel_case_types
typedef whisper_request_native = Pointer<Utf8> Function(Pointer<Utf8> body);

class Whisper {
  String whisper_lib = "libwhisper.so";
  Whisper({
    String? whisperLib,
  }) {
    if (whisperLib != null) {
      whisper_lib = whisperLib;
    }
  }

  DynamicLibrary openLib({
    String? whisperLib,
  }) {
    whisperLib ??= whisper_lib;
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    } else {
      return DynamicLibrary.open(whisperLib);
    }
  }

  Transcribe request({
    required WhisperRequest whisperRequest,
    String? whisperLib,
  }) {
    whisperLib ??= whisper_lib;
    try {
      var res = openLib(
        whisperLib: whisperLib,
      )
          .lookupFunction<whisper_request_native, whisper_request_native>(
              "request")
          .call(whisperRequest.toString().toNativeUtf8());
      Map result = json.decode(res.toDartString());
      return Transcribe(result);
    } catch (e) {
      print(e);
      return Transcribe({"@type": "error", "message": "${e.toString()}"});
    }
  }
}

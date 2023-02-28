// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';
import 'package:universal_io/io.dart';
import 'package:ffi/ffi.dart';
import "scheme/scheme.dart";
import "whisper_request.dart";
import "package:whisper_dart/api/api.dart" as whisper_api;
import "package:whisper_dart/scheme/scheme.dart" as whisper_scheme;

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

  Future<WhisperResponse> request({
    required WhisperRequest whisperRequest,
    String? whisperLib,
  }) async {
    whisperLib ??= whisper_lib;
    Map result = await Isolate.run(() async {
      Pointer<Utf8> data = whisperRequest.toString().toNativeUtf8();
      var res = openLib(whisperLib: whisperLib).lookupFunction<whisper_request_native, whisper_request_native>("request").call(data);
      Map result = json.decode(res.toDartString());
      malloc.free(data);
      return result;
    });
    return WhisperResponse(result);
  }

  Future<whisper_scheme.Transcribe> transcribe({
    required String audio,
    required String model,
    bool is_translate = false,
    int threads = 6,
    bool is_verbose = false,
    String language = "id",
    bool is_special_tokens = false,
    bool is_no_timestamps = false,
    String? whisperLib,
  }) async {
    // whisperLib ??= whisper_lib;
    WhisperResponse result = await request(
      whisperRequest: WhisperRequest(
        whisper_api.GetTextFromWavFile.create(
          special_type: "getTextFromWavFile",
          audio: audio,
          model: model,
          is_no_timestamps: is_no_timestamps,
          is_special_tokens: is_special_tokens,
          is_translate: is_translate,
          is_verbose: is_verbose,
          language: language,
          threads: threads,
        ).toJson(),
      ),
      whisperLib: whisperLib,
    );
    return whisper_scheme.Transcribe(result.toJson());
  }

  Future<whisper_scheme.Version> getVersion({
    String? whisperLib,
  }) async {
    // whisperLib ??= whisper_lib;
    WhisperResponse result = await request(
      whisperRequest: WhisperRequest(
        whisper_api.GetVersion.create(
          special_type: "getVersion",
        ).toJson(),
      ),
      whisperLib: whisperLib,
    );
    return whisper_scheme.Version(result.toJson());
  }
}

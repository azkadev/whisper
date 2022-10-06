// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';
import 'package:universal_io/io.dart';

import 'package:ffi/ffi.dart';

// ignore: camel_case_types
typedef whisper_request_native = Pointer<Utf8> Function(Pointer<Utf8> body);

class Whisper {
  late String whisper_lib = "whisper.so";
  Whisper({String? whisperLib}) {
    if (whisperLib != null) {
      whisper_lib = whisperLib;
    }
  }

  DynamicLibrary get openLib {
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    } else {
      return DynamicLibrary.open(whisper_lib);
    }
  }

  Map get test {
    try {
      var res = openLib.lookupFunction<Pointer<Utf8> Function(), Pointer<Utf8> Function()>("getString").call();
      var result = json.decode(res.toDartString());
      return result;
    } catch (e) {
      return {"@type": "error"};
    }
  }

  WhisperResponse transcribe({
    required WhisperRequest whisperRequest,
  }) {
    try {
      var res = openLib.lookupFunction<whisper_request_native, whisper_request_native>("request").call(whisperRequest.toString().toNativeUtf8());
      Map result = json.decode(res.toDartString());
      return WhisperResponse(result);
    } catch (e) {
      return WhisperResponse({"@type": "error"});
    }
  }
}

/// Don't forget to run malloc.free with result!
Pointer<Pointer<Utf8>> strListToPointer(List<String> strings) {
  List<Pointer<Utf8>> utf8PointerList = strings.map((str) => str.toNativeUtf8()).toList();

  final Pointer<Pointer<Utf8>> pointerPointer = malloc.allocate(utf8PointerList.length);

  strings.asMap().forEach((index, utf) {
    pointerPointer[index] = utf8PointerList[index];
  });

  return pointerPointer;
}

class WhisperArgs {
  late List<String> args;
  WhisperArgs(this.args);
  Pointer<Pointer<Utf8>> toNativeList() {
    List<Pointer<Utf8>> utf8PointerList = args.map((str) => str.toNativeUtf8()).toList();

    final Pointer<Pointer<Utf8>> pointerPointer = malloc.allocate(utf8PointerList.length);

    args.asMap().forEach((index, utf) {
      pointerPointer[index] = utf8PointerList[index];
    });
    return pointerPointer;
  }
}

class WhisperRequest {
  late Map rawData;
  WhisperRequest(this.rawData);

  factory WhisperRequest.fromWavFile({
    required File audio,
    required File model,
    bool is_translate = false,
    int threads = 4,
    bool is_verbose = false,
    String language = "id",
    bool is_special_tokens = false,
    bool is_no_timestamps = false,
  }) {
    return WhisperRequest({
      "@type": "getTextFromWavFile",
      "is_translate": is_translate,
      "threads": threads,
      "is_verbose": is_verbose,
      "language": language,
      "is_special_tokens": is_special_tokens,
      "is_no_timestamps": is_no_timestamps,
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

  String? get special_type {
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

import 'dart:convert';
import 'dart:ffi';
import 'package:universal_io/io.dart';

import 'package:ffi/ffi.dart';

typedef transcribe_native = Pointer<Utf8> Function(Int argc, Pointer<Pointer<Utf8>> args, Bool isLog);
typedef transcribe_dart = Pointer<Utf8> Function(int argc, Pointer<Pointer<Utf8>> args, bool isLog);

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
    int argc = 1,
    required WhisperArgs args,
    bool isLog = false,
  }) {
    try {
      var res = openLib.lookupFunction<transcribe_native, transcribe_dart>("transcribe").call(argc, args.toNativeList(), isLog);
      Map result = json.decode(res.toDartString());
      return WhisperResponse(result);
    } catch (e) {
      return WhisperResponse({"@type": "error"});
    }
  }
}
/// Don't forget to run malloc.free with result!
Pointer<Pointer<Utf8>> strListToPointer(List<String> strings) {
  List<Pointer<Utf8>> utf8PointerList =
      strings.map((str) => str.toNativeUtf8()).toList();

  final Pointer<Pointer<Utf8>> pointerPointer =
      malloc.allocate(utf8PointerList.length);

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

  factory WhisperRequest.fromWavFile() {
    return WhisperRequest({});
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

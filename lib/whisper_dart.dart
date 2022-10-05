import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

void main(List<String> arguments) {
  try {
    DynamicLibrary dynamicLibrary = DynamicLibrary.open("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper.cpp/azka.so");
    //  var res = dynamicLibrary.lookupFunction<Void Function(), void Function()>("test").call();

    //var res = dynamicLibrary.lookupFunction<Pointer<Utf8> Function(Int argc,), Pointer<Utf8> Function(int argc)>("transcribe").call(1);
    var res = dynamicLibrary.lookupFunction<Pointer<Utf8> Function(), Pointer<Utf8> Function()>("getString").call();
    // print(res.toDartString());
    var result = json.decode(res.toDartString());
    print(result["text"]);
  } catch (e) {
    print(e);
  }
}

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

  speectToTextFromFile() {}
}

int calculate() {
  return 6 * 7;
}

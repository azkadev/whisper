import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef request_native = Pointer<Utf8> Function(Pointer<Utf8> body);
void main() {
  DynamicLibrary lib = DynamicLibrary.open(
      "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/whisper.cpp/test.so");
  try {
    var res = lib
        .lookupFunction<request_native, request_native>("request")
        .call(json.encode({"@type": "azka"}).toNativeUtf8());
    print(res.toDartString());
  } catch (e) {
    print(e);
  }
}

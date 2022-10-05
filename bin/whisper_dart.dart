import 'dart:convert';
import 'dart:ffi';

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

import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) {
  Whisper whisper = Whisper(whisperLib: "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/whisper.cpp/whisper.so");
  DynamicLibrary openLib = whisper.openLib;
  try {
    var res = openLib.lookupFunction<Pointer<Void> Function(Pointer<Utf8> args), Pointer<void> Function(Pointer<Utf8> args)>("test").call("sakosa, sdsdsdsd".toNativeUtf8());
    
  } catch (e) {
    print(e);
  }
}

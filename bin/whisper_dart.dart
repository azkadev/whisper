import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) {
  Whisper whisper = Whisper(whisperLib: "whisper.cpp/whisper.so");
  DynamicLibrary openLib = whisper.openLib;
  try {
    var res = whisper.transcribe(
      args: WhisperArgs("-m models/ggml-small.bin -f samples/output.wav --language id".split(" ")),
    );
    print(res.toString());
  } catch (e) {
    print(e);
  }
}

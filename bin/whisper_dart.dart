import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:whisper_dart/whisper_dart.dart';
void main(List<String> arguments) {
  Whisper whisper = Whisper(
    whisperLib: "whisper.cpp/whisper.so",
  );
  DateTime time = DateTime.now();
  try {
    var res = whisper.transcribe(
      args: WhisperArgs([
        "-m", "models/ggml-model-whisper-small.bin", "-f", "samples/indonesia.wav", "--language", "id"
      ]),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}
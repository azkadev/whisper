// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) {
  Directory current = Directory.current;
  DateTime time = DateTime.now();

  Whisper whisper = Whisper();
  try {
    var res = whisper.request(
      request: WhisperRequest.fromWavFile(
        audio: File("${current.path}/samples/your_sample.wav"),
        // check it here: https://github.com/ggerganov/whisper.cpp/tree/master/models
        model: File("${current.path}/models/your_model.bin"),
      ),
    );
    print(res.text);
    print(time.millisecondsSinceEpoch);
  } catch (e) {
    print(e);
  }
}

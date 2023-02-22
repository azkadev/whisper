// ignore_for_file: non_constant_identifier_names

import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) async {
  // DateTime time = DateTime.now();
  // print(res);
  Whisper whisper = Whisper(
    whisperLib:
        "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/package/whisper_flutter/example/build/linux/x64/release/bundle/lib/libwhisper.so",
  );
  var version = await whisper.getVersion();
  print(version.message);
  var res = await whisper.transcribe(
    audio: File(
            "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav")
        .path,
    model: File(
            "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/ggml-model-whisper-base.bin")
        .path,
  );
  print(res.toString());
}

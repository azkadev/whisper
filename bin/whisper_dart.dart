// ignore_for_file: non_constant_identifier_names

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();
  // print(res);
  Whisper whisper = Whisper(
    whisperLib: "native_lib/whisper_dart.so",
  );
  try {
    var res = whisper.request(
      whisperRequest: WhisperRequest.fromWavFile(
        // audio: WhisperAudioconvert.convert(
        //   audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
        //   audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        // ),
        audio: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        model: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/models/ggml-model-whisper-small.bin"),
      ),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();
  FFmpeg fFmpeg = FFmpeg(pathFFmpeg: "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/ffmpeg/ffmpeg");
  var res = fFmpeg.convertAudioToWavWhisper(
    pathAudioInput: "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/audio.ogg",
    pathAudioOutput: "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav",
  );
  print(res);
  Whisper whisper = Whisper(
    whisperLib: "whisper.cpp/whisper.so",
  );
  try {
    var res = whisper.transcribe(
      args: WhisperArgs([
        // "-m",
        // "models/ggml-model-whisper-small.bin",
        // "-f",
        // "samples/indonesia.wav",
        // "--language",
        // "id"
      ]),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}

extension ConvertAudioToWavWhisper on FFmpeg {
  bool convertAudioToWavWhisper({
    required String pathAudioInput,
    required String pathAudioOutput,
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
  }) {
    File input_audio_file = File(pathAudioInput);
    if (!input_audio_file.existsSync()) {
      return false;
    }
    File output_audio_file = File(pathAudioOutput);
    if (input_audio_file.existsSync()) {
      output_audio_file.deleteSync(recursive: true);
    }

    FFmpegRawResponse res = invokeSync(
      pathFFmpeg: pathFFmpeg,
      fFmpegArgs: FFmpegArgs(
        ["-i", pathAudioInput, "-ar", "16000", "-ac", "1", "-c:a", "pcm_s16le", pathAudioOutput],
      ),
    );
    if (res.special_type == "ok") {
      return true;
    } else {
      print(res.toJson());
    }
    return false;
  }
}

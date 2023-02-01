// ignore_for_file: non_constant_identifier_names

import 'package:ffmpeg_dart/ffmpeg_dart.dart';
import 'package:universal_io/io.dart';

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
    if (output_audio_file.existsSync()) {
      output_audio_file.deleteSync(recursive: true);
    }
    FFmpegRawResponse res = invokeSync(
      pathFFmpeg: pathFFmpeg,
      fFmpegArgs: FFmpegArgs(
        [
          "-i",
          pathAudioInput,
          "-ar",
          "16000",
          "-ac",
          "1",
          "-c:a",
          "pcm_s16le",
          pathAudioOutput,
        ],
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

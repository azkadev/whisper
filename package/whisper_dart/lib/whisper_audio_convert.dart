// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'package:ffmpeg_dart/ffmpeg_dart.dart';
import 'package:universal_io/io.dart';
import 'extension/ffmpeg.dart';

class WhisperAudioconvert {
  WhisperAudioconvert();
  static File convert({
    required File audioInput,
    required File audioOutput,
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
    Duration? timeout,
  }) {
    timeout ??= Duration(seconds: 10);
    DateTime time_expire = DateTime.now().add(timeout);
    var res = FFmpeg(pathFFmpeg: pathFFmpeg).convertAudioToWavWhisper(
      pathAudioInput: audioInput.path,
      pathAudioOutput: audioOutput.path,
      pathFFmpeg: pathFFmpeg,
      fFmpegArgs: fFmpegArgs,
      workingDirectory: workingDirectory,
      environment: environment,
      runInShell: runInShell,
    );
    while (true) {
      if (DateTime.now().isAfter(time_expire)) {
        throw "time out";
      }
      if (res) {
        if (audioOutput.existsSync()) {
          return audioOutput;
        }
      } else {
        if (!audioInput.existsSync()) {
          throw "audio input not found";
        }
      }
    }
  }
}

import "dart:io";

import "package:whisper_dart/scheme/scheme.dart";
import "package:whisper_dart/whisper_dart.dart";

void main(List<String> args) async {
  Whisper whisper = Whisper(whisperLib: "./path_library_shared_whisper");
  Version whisperVersion = await whisper.getVersion();
  print(whisperVersion);

  Transcribe transcribe = await whisper.transcribe(
    audio: "./path_file_audio_wav_16_bit",
    model: "./path_model_whisper_bin",
    language: "id", // language
  );
  print(transcribe);

  /// auto convert any fideo
  Transcribe transcribeAnyAudio = await whisper.transcribe(
    audio: WhisperAudioconvert.convert(
      audioInput: File("./path_audio_any_format"),
      audioOutput: File("./path_audio_convert.wav"),
    ).path,
    model: "./path_model_whisper_bin",
    language: "id", // language
  );
  print(transcribeAnyAudio);
}

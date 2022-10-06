# Whisper

Whisper library speech to text offline, 

## Refrence
1. [Whisper-Official](https://github.com/openai/whisper)
2. [Whisper.cpp](https://github.com/ggerganov/whisper.cpp)

## Install

```bash
dart pub add whisper_dart
```

## Compile library

```bash
git clone https://github.com/azkadev/whisper_dart.git
cd whisper.cpp
chmod 777 compile.sh
bash ./download-ggml-model.sh base.en
./compile.sh
```

## Tested on
1. OS: Ubuntu 20.4
   CPU: Amd Ryzen 5500u
   Ram: 8gb

## example

```dart
// ignore_for_file: non_constant_identifier_names

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();
  FFmpeg fFmpeg = FFmpeg(
    pathFFmpeg: "./ffmpeg/ffmpeg",
  );
  var res = fFmpeg.convertAudioToWavWhisper(
    pathAudioInput: "./audio.ogg",
    pathAudioOutput: "./samples/output.wav",
  );
  // print(res);
  Whisper whisper = Whisper(
    whisperLib: "whisper.cpp/whisper.so",
  );
  try {
    var res = whisper.transcribe(
      whisperRequest: WhisperRequest.fromWavFile(
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
```
result
```bash
{
  "@type":"transcribe",
  "text":" Baby, aku pergi dulu ya, babai sayang. *muach*"
}
```

## Testing
```dart
import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:whisper_dart/whisper_dart.dart';
void main(List<String> arguments) {
  Whisper whisper = Whisper(whisperLib: "path_to/whisper.so");
  print(whisper.test);
}
```

result
```json
{
  "@type":"ok",
  "text":" And so my fellow Americans, ask not what your country can do for you, ask what you can do for your country."
}
```

Language Support 

![](https://github.com/openai/whisper/raw/main/language-breakdown.svg)
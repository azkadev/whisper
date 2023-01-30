# Whisper

Whisper library speech to text offline,

## Refrence

1. [Whisper-Official](https://github.com/openai/whisper)
2. [Whisper.cpp](https://github.com/ggerganov/whisper.cpp)

## Screenshot

[![Screenshot from 2022-10-24 17-28-26](https://user-images.githubusercontent.com/82513502/197506276-acd71547-5062-47c0-908c-95d3ed00b092.png)](https://www.youtube.com/watch?v=qQWPE3EvOS0)

## Install

```bash
dart pub add whisper_dart
```

## Tested on

1. OS: Ubuntu 20.4
   CPU: AMD Ryzen 5500u
   Ram: 8gb
2. OS: Windows 11 Pro 22H2 (22621.1105)
   CPU: AMD Ryzen 3600
   Ram: 16gb
3. OS: Android 11
   CPU: Snapdragon 665
   Ram: 3gb
4. OS: Android 13
   CPU: Snapdragon 730
   Ram: 4gb

## example

auto convert a given audio to a proper wav accepted by whisper, `ffmpeg` must be installed

```dart
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();

  Whisper whisper = Whisper(
    whisperLib: "whisper.cpp/whisper.so",
  );
  try {
    var res = whisper.request(
      whisperRequest: WhisperRequest.fromWavFile(
        /// auto convert to wav 16
        audio: WhisperAudioconvert.convert(
          audioInput: File("samples/audio.ogg"),
          audioOutput: File("samples/output.wav"),
        ),
        model: File("models/ggml-model-whisper-small.bin"),
      ),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}
```

## example 2

example convert audio to text without auto convert

```dart
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();

  Whisper whisper = Whisper(
    whisperLib: "whisper.cpp/whisper.so",
  );
  try {
    var res = whisper.request(
      whisperRequest: WhisperRequest.fromWavFile(
        audio: File("samples/output.wav"),
        model: File("models/ggml-model-whisper-small.bin"),
      ),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}
```

result

```json
{
  "@type": "transcribe",
  "text": " And so my fellow Americans, ask not what your country can do for you, ask what you can do for your country."
}
```

Language Support

![](https://github.com/openai/whisper/raw/main/language-breakdown.svg)

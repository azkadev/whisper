# Whisper

Whisper library speech to text offline, 

## Refrence
1. [Whisper-Official](https://github.com/openai/whisper)
2. [Whisper.cpp](https://github.com/ggerganov/whisper.cpp)

> this library is not in maintenance, just for example, if you want to transcribe audio to text please use [galaxeus_ai](https://github.com/galaxeus/galaxeus_ai)

## Screenshot

[![Screenshot from 2022-10-24 17-28-26](https://user-images.githubusercontent.com/82513502/197506276-acd71547-5062-47c0-908c-95d3ed00b092.png)](https://www.youtube.com/watch?v=qQWPE3EvOS0)



## Install

```bash
dart pub add whisper_dart
```

## Compile library

1. for linux
```bash
git clone --recursive https://github.com/azkadev/whisper_dart.git
cd whisper_dart
cd native_lib
make
sudo make install
```

2. for android
```bash
git clone --recursive https://github.com/azkadev/whisper_dart.git
cd whisper_dart
cd native_lib
make
make compile.android
```

## Tested on
I only have this device, so sorry I can't test other devices
1. OS: Ubuntu 20.4
   CPU: Amd Ryzen 5500u
   Ram: 8gb
2. Os: Android 11
   CPU: Snapdragon 665
   Ram: 3gb

## example
example dengan auto convert dari semua jenis audio ke wav whisper, `ffmpeg` harus terinstall
```dart
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
```
result
```bash
{
  "@type":"transcribe",
  "text":" Baby, aku pergi dulu ya, babai sayang. *muach*"
}
```

## example 2

example convert audio to text without auto convert
```dart
// ignore_for_file: non_constant_identifier_names
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now(); 
  // print(res);
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
  "@type":"transcribe",
  "text":" And so my fellow Americans, ask not what your country can do for you, ask what you can do for your country."
}
```

Language Support 

![](https://github.com/openai/whisper/raw/main/language-breakdown.svg)

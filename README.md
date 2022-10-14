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
example dengan auto convert dari semua jenis audio ke wav whisper

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
        audio: WhisperAudioconvert.convert(
          audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
          audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        ),
        model: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/models/ggml-model-whisper-small.bin"),
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
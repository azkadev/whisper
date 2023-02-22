# Whisper Flutter

## Install library

```bash
flutter pub add whisper_flutter
```

## import library

```bash
import 'package:whisper_flutter/whisper_flutter.dart';
```

## Bagaimana Cara mengcompile whisper.cpp ke shared lirbary?

Anda tidak perlu ribet mengcompile karena sudah automatis compile saat anda build aplikasi flutter

## Quickstart

```dart

Whisper whisper = Whisper();
var res = await whisper.request(
    whisperLib: "libwhisper.so",
    whisperRequest: WhisperRequest.fromWavFile(
        audio: File(audio),
        model: File(model),
    ),
);
```
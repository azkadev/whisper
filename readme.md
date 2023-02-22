# Whisper

Whisper adalah project open source dari [openai](https://github.com/openai) untuk mengeluarkan text dari suara, project ini menggunakan [whisper.cpp](https://github.com/ggerganov/whisper.cpp), Dan menggunakan [FFMPEG](https://github.com/FFmpeg/FFmpeg) untuk mengconvert audio ke wav, Project ini bisa di jalankan di client side dan server side dan tidak memerlukan internet.

## Demo

1. Flutter App

https://user-images.githubusercontent.com/82513502/220721473-3303ab00-e272-4b58-bfe5-86fb9db05814.mp4

## Resources

Assets yang di perlukan.

1. [Datasets Whisper GGML](https://huggingface.co/datasets/ggerganov/whisper.cpp)

### Memory Usage

| Model  | Disk   | Mem    |
|--------|--------|--------|
| tiny   | 75 MB  | 125 MB |
| base   | 142 MB | 210 MB |
| small  | 466 MB | 600 MB |
| medium | 1.5 GB | 1.7 GB |
| large  | 2.9 GB | 3.3 GB |

### Roadmap Features

Features yang akan datang

1. [x] Cross Platform (Android / linux / windows / ios / macos)
2. [ ] Add FFMPEG KIT Cross Platform (Android / linux / windows / ios / macos)
3. [ ] Docs

### TESTED ON

| NO | OS                                   | CPU             | RAM     |
|----|--------------------------------------|-----------------|---------|
| 1  | Ubuntu 20.04                         | AMD RYZEN 5500U | 8GB     |
| 2  | Android 11                           | Snapdragon 665  | 3GB     |
| 3  | Android 5                            | Snapdragon 430  | 2GB     |
| 4  | Windows 11 Pro 22H2 (22621.1105)     | AMD RYZEN 3600  | 16GB    |
| 5  | Android 13                           | Snapdragon 730  | 4GB     |
| 6  | Pixel 3a API 33 AndroiD x64 emulator | Unknown         | Unknown |

Untuk devices lainya saya tidak tahu bisa / enggak karena saya tidak ada devices

## Contributors

1. [JeisonSanches](https://github.com/JeisonSanches) - [Whisper Flutter](https://github.com/azkadev/whisper_dart/tree/main/package/whisper_flutter)


## Quickstart


1. Dart
Jika anda ingin menggunakan whisper di cli / backend server anda menggunakan ini

- Install package dulu
```bash
dart pub add whisper_dart
```

- Tambahkan library

```dart
import "package:whisper_dart/whisper_dart.dart";
```


2. Flutter app

Jika anda ingin menggunakan whisper di app anda menggunakan ini

- Install package dulu
```bash
flutter pub add wisper_flutter
```

- Tambahkan library

```dart
import "package:whisper_flutter/whisper_flutter.dart";
```


### Code


```bash
Whisper whisper = Whisper();
var res = await whisper.request(
    whisperLib: "libwhisper.so", # jika anda menggunakan whisper flutter anda tidak perlu menambahkan whisperLib karena sudah automatis
    # pastikan audio yang kamu gunakan berformat wav ya
    whisperRequest: WhisperRequest.fromWavFile(
        audio: File(audio),
        model: File(model),
    ),
);
```
 
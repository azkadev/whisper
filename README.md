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
/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names

import 'dart:io';

 import 'package:general_lib/general_lib.dart';
 import 'package:whisper_dart/whisper_dart.dart'; 

void main(List<String> arguments) {
  DateTime time = DateTime.now();
  // print(res);
  Whisper whisper = Whisper(
  );
  whisper.ensureInitialized(
    whisperLibraryPath: "native_lib/whisper_dart.so",
  );
  try {
    var res = whisper.request(
      whisperRequest: WhisperRequest.fromWavFile( 
        audio: File("samples/jfk.wav"),
        model: File("models/ggml-small.bin"),
        language: "en",
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

## Assets
- [Models](https://huggingface.co/ggerganov/whisper.cpp/tree/main)

Language Support 

![](https://github.com/openai/whisper/raw/main/language-breakdown.svg)

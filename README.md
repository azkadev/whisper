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
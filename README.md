# Whisper

Whisper library speech to text offline, 


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
{"@type":"ok","text":" And so my fellow Americans, ask not what your country can do for you, ask what you can do for your country."}
```
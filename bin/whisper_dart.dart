import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) {
  Whisper whisper = Whisper(whisperLib: "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/whisper.cpp/azka.so");
  DateTime time = DateTime.now();
  print(json.encode(whisper.test));
  print(convertToAgo(time.millisecondsSinceEpoch));
}

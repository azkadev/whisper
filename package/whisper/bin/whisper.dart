import 'dart:io';

import 'package:general_lib/general_lib.dart';
import 'package:whisper/core/core.dart';
import 'package:whisper/dart/dart.dart';

void main(List<String> arguments) async {
  print("Hello Start");
  WhisperDart.initalized(
    libraryWhisperPath: "/home/galaxeus/Documents/librarys/whisper/native/build/lib/libwhisper.so",
  );
  final Whisper whisper = WhisperDart();
  whisper.print("Hello World");

  Map result = whisper.invoke(parameters: {
    "@type": "getVersion",
  });
  result.printPretty();
  print("done");
  exit(0);
}

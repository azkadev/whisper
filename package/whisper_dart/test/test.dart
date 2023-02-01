import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';

void main() async {
  jsonToDart(
    {
      "@type": "Transcribe",
      "text": "",
    },
    className: "Transcribe",
  ).saveToFile(Directory(
      "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/package/whisper_dart/lib/scheme"));
}

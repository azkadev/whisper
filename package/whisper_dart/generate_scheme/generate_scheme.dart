import 'package:galaxeus_lib/json_to_script_dart/json_to_script.dart';
import 'package:universal_io/io.dart';

void main(List<String> args) async {
  await jsonToScripts(
    [
      {
        "@type": "Error",
        "message": "",
      },
      {
        "@type": "Transcribe",
        "text": "",
      },
      {
        "@type": "WhisperResponse",
        "text": "",
        "message": "",
      },
      {
        "@type": "Version",
        "message": "",
      },
    ],
    directory: Directory(
        "/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/package/whisper_dart/lib/scheme"),
  );
}

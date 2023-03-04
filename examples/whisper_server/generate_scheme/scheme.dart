import 'dart:io';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as path;
import "package:galaxeus_lib/json_to_script_dart/json_to_script.dart";

void main(List<String> args) async {
  Directory directory_lib = Directory(path.join(Directory.current.path, "lib"));
  Directory directory_lib_scheme = Directory(path.join(directory_lib.path, "scheme"));
  if (!directory_lib_scheme.existsSync()) {
    await directory_lib_scheme.create(recursive: true);
  }
  List<Map<String, dynamic>> datas = [
    {
      "@type": "Transcribe",
      "text": "",
    },
    {
      "@type": "getTextFromAudio",
      "name": "",
      "data": [1],
    },
    {
      "@type": "error",
      "message": "",
      "description": "",
    },
    {
      "@type": "task",
      "key": "",
      "password": "",
      "expire_date": DateTime.now().millisecondsSinceEpoch,
    }
  ];

  await jsonToScripts(
    datas,
    directory: directory_lib_scheme,
  );
}

import 'dart:io';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  Directory directory_lib = Directory(path.join(Directory.current.path, "lib"));
  Directory directory_lib_isar_scheme = Directory(path.join(directory_lib.path, "isar_scheme"));
  if (!directory_lib_isar_scheme.existsSync()) {
    await directory_lib_isar_scheme.create(recursive: true);
  }
  List<Map<String, dynamic>> datas = [
    {
      "@type": "Transcribe",
      "key": "",
      "password": "",
      "text": "",
      "expire_date": DateTime.now().millisecondsSinceEpoch,
    },
  ];

  for (var i = 0; i < datas.length; i++) {
    Map<String, dynamic> data = datas[i];
    String method_name = "";
    if (data["@type"] is String) {
      method_name = data["@type"];
    }
    if (method_name.isEmpty) {
      continue;
    }
    method_name = method_name.camelCaseClass();
    JsonDataScript jsonDataScript = jsonToIsar(
      data,
      className: method_name,
    );

    await jsonDataScript.saveToFile(directory_lib_isar_scheme);
  }
}

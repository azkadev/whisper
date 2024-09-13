// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:io';
import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;
import 'package:whisper/schemes/api.dart';
import 'package:whisper/schemes/respond.dart';
void main(List<String> args) async {
  Directory directory = Directory(path.join(Directory.current.uri.toFilePath(), "lib", "scheme"));
  if (directory.existsSync()) {
    directory.deleteSync(recursive: true);
  }
  directory.createSync(recursive: true);
 
  await jsonToScripts(api_schemes, directory: Directory(path.join(directory.uri.toFilePath(), "api")));
  await jsonToScripts(respond_schemes, directory: Directory(path.join(directory.uri.toFilePath(), "respond")));



  final Directory directory_api = Directory(path.join(
    Directory.current.path,
    "lib",
    "api",
  ));

  if (directory_api.existsSync() == false) {
    directory_api.createSync(recursive: true);
  }
  final File file = File(path.join(directory_api.path, "api.dart"));
  String script = """
// ignore_for_file: non_constant_identifier_names

import 'package:whisper/dart/dart.dart';
import 'package:whisper/scheme/api/api.dart';
import 'package:whisper/scheme/respond/respond.dart';

extension WhisperApiExtension on Whisper {
 
""";
  for (final Map element in api_schemes) {
    if (element["@type"] is String == false) {
      continue;
    }
    if (element["@return_type"] is String == false) {
      element["@return_type"] = "ok";
    }
    final String special_type = element["@type"].toString().camelCaseClass();

    final String return_type = element["@return_type"].toString().camelCaseClass();

    script += "\n";
    script += """

  /// generate
  Future<${return_type}> api_${special_type.toLowerCaseFirstData()}({
    required ${special_type} ${special_type.toLowerCaseFirstData()}Parameters, 
  }) async { 
    return await invokeBuilder(
      parameters: ${special_type.toLowerCaseFirstData()}Parameters.toJson(), 
      onResult: (result) {
        return ${return_type}(result);
      },
    );
  }

"""
        .trim();
    script += "\n";
  }
  script += "\n}";
  await file.writeAsString(script);
  Process.runSync("dart", [
    "format",
    directory.path,
  ]);
  Process.runSync("dart", [
    "format",
    directory_api.path,
  ]);
}


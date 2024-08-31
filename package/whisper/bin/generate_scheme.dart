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

}


// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:isar/isar.dart';
part "transcribe.g.dart";

@collection
class Transcribe {
  Id id = Isar.autoIncrement;
  String special_type = "Transcribe";
  String key = "";
  String password = "";
  String text = "";
  int expire_date = 1677962729539;

  /// operator map data
  operator [](key) {
    return toJson()[key];
  }

  /// operator map data
  void operator []=(key, value) {
    if (key == "@type") {
      special_type = value;
    }

    if (key == "key") {
      key = value;
    }

    if (key == "password") {
      password = value;
    }

    if (key == "text") {
      text = value;
    }

    if (key == "expire_date") {
      expire_date = value;
    }
  }

  /// return original data json
  Map toMap() {
    return toJson();
  }

  /// return original data json
  Map toJson() {
    return {
      "@type": special_type,
      "key": key,
      "password": password,
      "text": text,
      "expire_date": expire_date,
    };
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(toJson());
  }
}

// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Transcribe {
  Map rawData;

  Transcribe(this.rawData);

  static Map get defaultData {
    return {"@type": "Transcribe", "text": ""};
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get text {
    try {
      if (rawData["text"] is String == false) {
        return null;
      }
      return rawData["text"] as String;
    } catch (e) {
      return null;
    }
  }

  static Transcribe create({
    String? special_type,
    String? text,
  }) {
    Map jsonData = Transcribe.defaultData;
    Map jsonCreate = {
      "@type": special_type,
      "text": text,
    };

    jsonCreate.forEach((key, value) {
      try {
        if (value != null) {
          jsonData[key] = value;
        }
      } catch (e, stack) {
        print("Transcribe ${e.toString()}, ${stack.toString()}");
      }
    });
    return Transcribe(jsonData);
  }

  /// operator map data
  operator [](key) {
    return rawData[key];
  }

  /// operator map data
  void operator []=(key, value) {
    rawData[key] = value;
  }

  /// return original data json
  Map toMap() {
    return rawData;
  }

  /// return original data json
  Map toJson() {
    return rawData;
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(rawData);
  }
}

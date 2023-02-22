// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class Error extends JsonDart {
  Error(super.rawData);

  static Map get defaultData {
    return {"@type": "Error", "message": ""};
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

  String? get message {
    try {
      if (rawData["message"] is String == false) {
        return null;
      }
      return rawData["message"] as String;
    } catch (e) {
      return null;
    }
  }

  static Error create({
    String? special_type,
    String? message,
  }) {
    Error error = Error({
      "@type": special_type,
      "message": message,
    });

    return error;
  }
}

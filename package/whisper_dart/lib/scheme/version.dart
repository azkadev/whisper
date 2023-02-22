// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class Version extends JsonDart {
  Version(super.rawData);

  static Map get defaultData {
    return {"@type": "Version", "message": ""};
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

  static Version create({
    String? special_type,
    String? message,
  }) {
    Version version = Version({
      "@type": special_type,
      "message": message,
    });

    return version;
  }
}

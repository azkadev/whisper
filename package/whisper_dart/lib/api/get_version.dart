// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class GetVersion extends JsonDart {
  GetVersion(super.rawData);

  static Map get defaultData {
    return {"@type": "getVersion"};
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

  static GetVersion create({
    String? special_type,
  }) {
    GetVersion getVersion = GetVersion({
      "@type": special_type,
    });

    return getVersion;
  }
}

// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class GetVersion extends JsonScheme {
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

  set special_type(String? value) {
    rawData["@type"] = value;
  }

  static GetVersion create({
    String special_type = "getVersion",
  }) {
    // GetVersion getVersion = GetVersion({
    Map getVersion_data_create_json = {
      "@type": special_type,
    };

    getVersion_data_create_json.removeWhere((key, value) => value == null);
    GetVersion getVersion_data_create = GetVersion(getVersion_data_create_json);

    return getVersion_data_create;
  }
}

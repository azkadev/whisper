// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class Version extends JsonScheme {
  Version(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {"@type": "version"};
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == version
  /// if same return true
  bool json_scheme_utils_checkDataIsSameBySpecialType() {
    return rawData["@type"] == defaultData["@type"];
  }

  /// check value data whatever do yout want
  bool json_scheme_utils_checkDataIsSameBuilder({
    required bool Function(Map rawData, Map defaultData) onResult,
  }) {
    return onResult(rawData["@type"], defaultData["@type"]);
  }

  /// create [Version]
  /// Empty
  static Version empty() {
    return Version({});
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

  static Version create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "version",
  }) {
    // Version version = Version({
    final Map version_data_create_json = {
      "@type": special_type,
    };

    version_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (version_data_create_json.containsKey(key) == false) {
          version_data_create_json[key] = value;
        }
      });
    }
    return Version(version_data_create_json);
  }
}

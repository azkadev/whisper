// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

class GetVersion extends JsonScheme {
  GetVersion(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {"@type": "getVersion", "@return_type": "version"};
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == getVersion
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

  /// create [GetVersion]
  /// Empty
  static GetVersion empty() {
    return GetVersion({});
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

  String? get special_return_type {
    try {
      if (rawData["@return_type"] is String == false) {
        return null;
      }
      return rawData["@return_type"] as String;
    } catch (e) {
      return null;
    }
  }

  set special_return_type(String? value) {
    rawData["@return_type"] = value;
  }

  static GetVersion create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "getVersion",
    String special_return_type = "version",
  }) {
    // GetVersion getVersion = GetVersion({
    final Map getVersion_data_create_json = {
      "@type": special_type,
      "@return_type": special_return_type,
    };

    getVersion_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (getVersion_data_create_json.containsKey(key) == false) {
          getVersion_data_create_json[key] = value;
        }
      });
    }
    return GetVersion(getVersion_data_create_json);
  }
}

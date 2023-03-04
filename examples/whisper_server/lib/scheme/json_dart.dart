// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

/// return original data json
class JsonDart {
  
  /// return original data json
  Map rawData;

  /// return original data json
  JsonDart(this.rawData);

  /// return original data json
  static Map get defaultData {
    return {
      "@type": "jsonDart",
    };
  }

  /// return original data json
  static JsonDart create({
    String? special_type,
  }) {
    Map jsonCreate = {
      "@type": special_type,
    };

    jsonCreate.forEach((key, value) {
      try {
        if (value == null) {
          jsonCreate.remove(value);
          // jsonCreate[key] = value;
        }
      } catch (e, stack) {
        print("Azka ${e.toString()}, ${stack.toString()}");
      }
    });
    return JsonDart(jsonCreate);
  }

  /// operator map data
  operator *(value) {}

  /// operator map data
  operator /(value) {}

  /// operator map data
  Map operator +(Map value) {
    rawData.addAll(value);
    return rawData;
  }

  /// return original data json
  Map operator -(List values) {
    utils_remove_by_keys_void(values);
    return rawData;
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
  void utils_remove_values_null_void() {
    rawData.forEach((key, value) {
      if (value == null) {
        rawData.remove(key);
      }
    });
  }

  /// return original data json
  Map utils_remove_values_null() {
    utils_remove_values_null_void();
    return rawData;
  }

  /// return original data json
  void utils_remove_by_values_void(List values) {
    rawData.forEach((key, value) {
      for (var element in values) {
        if (value == element) {
          rawData.remove(key);
        }
      }
    });
  }

  /// return original data json
  Map utils_remove_by_values(List values) {
    utils_remove_by_values_void(values);
    return rawData;
  }

  void utils_remove_by_keys_void(List keys) {
    for (var element in keys) {
      rawData.remove(element);
    }
  }

  /// return original data json
  Map utils_remove_by_keys(List keys) {
    utils_remove_by_keys_void(keys);
    return rawData;
  }

  /// return original data json
  Map utils_filter_by_keys(List keys) {
    Map jsonData = {};
    for (var key in keys) {
      jsonData[key] = rawData[key];
    }
    return jsonData;
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


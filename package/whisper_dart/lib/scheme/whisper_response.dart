// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class WhisperResponse extends JsonDart {
  WhisperResponse(super.rawData);

  static Map get defaultData {
    return {"@type": "WhisperResponse", "text": "", "message": ""};
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

  static WhisperResponse create({
    String? special_type,
    String? text,
    String? message,
  }) {
    WhisperResponse whisperResponse = WhisperResponse({
      "@type": special_type,
      "text": text,
      "message": message,
    });

    return whisperResponse;
  }
}

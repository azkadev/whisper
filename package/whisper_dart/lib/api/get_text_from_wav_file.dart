// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class GetTextFromWavFile extends JsonDart {
  GetTextFromWavFile(super.rawData);

  static Map get defaultData {
    return {
      "@type": "getTextFromWavFile",
      "is_translate": false,
      "threads": 12,
      "is_verbose": false,
      "language": "id",
      "is_special_tokens": false,
      "is_no_timestamps": false,
      "audio": "./audio.wav",
      "model": "./model.bin"
    };
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

  bool? get is_translate {
    try {
      if (rawData["is_translate"] is bool == false) {
        return null;
      }
      return rawData["is_translate"] as bool;
    } catch (e) {
      return null;
    }
  }

  int? get threads {
    try {
      if (rawData["threads"] is int == false) {
        return null;
      }
      return rawData["threads"] as int;
    } catch (e) {
      return null;
    }
  }

  bool? get is_verbose {
    try {
      if (rawData["is_verbose"] is bool == false) {
        return null;
      }
      return rawData["is_verbose"] as bool;
    } catch (e) {
      return null;
    }
  }

  String? get language {
    try {
      if (rawData["language"] is String == false) {
        return null;
      }
      return rawData["language"] as String;
    } catch (e) {
      return null;
    }
  }

  bool? get is_special_tokens {
    try {
      if (rawData["is_special_tokens"] is bool == false) {
        return null;
      }
      return rawData["is_special_tokens"] as bool;
    } catch (e) {
      return null;
    }
  }

  bool? get is_no_timestamps {
    try {
      if (rawData["is_no_timestamps"] is bool == false) {
        return null;
      }
      return rawData["is_no_timestamps"] as bool;
    } catch (e) {
      return null;
    }
  }

  String? get audio {
    try {
      if (rawData["audio"] is String == false) {
        return null;
      }
      return rawData["audio"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get model {
    try {
      if (rawData["model"] is String == false) {
        return null;
      }
      return rawData["model"] as String;
    } catch (e) {
      return null;
    }
  }

  static GetTextFromWavFile create({
    String? special_type,
    bool? is_translate,
    int? threads,
    bool? is_verbose,
    String? language,
    bool? is_special_tokens,
    bool? is_no_timestamps,
    String? audio,
    String? model,
    int n_processors = 1,
    bool split_on_word = false,
    bool no_fallback = false,
    bool diarize = false,
    bool speed_up = false,
  }) {
    GetTextFromWavFile getTextFromWavFile = GetTextFromWavFile({
      "@type": special_type,
      "is_translate": is_translate,
      "threads": threads,
      "is_verbose": is_verbose,
      "language": language,
      "is_special_tokens": is_special_tokens,
      "is_no_timestamps": is_no_timestamps,
      "audio": audio,
      "model": model,
      "n_processors": n_processors,
      "split_on_word": split_on_word,
      "no_fallback": no_fallback,
      "diarize": diarize,
      "speed_up": speed_up,
    });
    return getTextFromWavFile;
  }
}

// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class GetTextFromWavFile extends JsonScheme {

  
  GetTextFromWavFile(super.rawData);
   
  static Map get defaultData {
    return {"@type":"getTextFromWavFile","is_translate":false,"threads":12,"is_verbose":false,"language":"id","is_special_tokens":false,"is_no_timestamps":false,"audio":"./audio.wav","model":"./model.bin"};
  }

  
  String? get special_type {
    try {
      if (rawData["@type"] is String == false){
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


  
  bool? get is_translate {
    try {
      if (rawData["is_translate"] is bool == false){
        return null;
      }
      return rawData["is_translate"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_translate(bool? value) {
    rawData["is_translate"] = value;
  }


  
  num? get threads {
    try {
      if (rawData["threads"] is num == false){
        return null;
      }
      return rawData["threads"] as num;
    } catch (e) {
      return null;
    }
  }

  
  set threads(num? value) {
    rawData["threads"] = value;
  }


  
  bool? get is_verbose {
    try {
      if (rawData["is_verbose"] is bool == false){
        return null;
      }
      return rawData["is_verbose"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_verbose(bool? value) {
    rawData["is_verbose"] = value;
  }


  
  String? get language {
    try {
      if (rawData["language"] is String == false){
        return null;
      }
      return rawData["language"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set language(String? value) {
    rawData["language"] = value;
  }


  
  bool? get is_special_tokens {
    try {
      if (rawData["is_special_tokens"] is bool == false){
        return null;
      }
      return rawData["is_special_tokens"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_special_tokens(bool? value) {
    rawData["is_special_tokens"] = value;
  }


  
  bool? get is_no_timestamps {
    try {
      if (rawData["is_no_timestamps"] is bool == false){
        return null;
      }
      return rawData["is_no_timestamps"] as bool;
    } catch (e) {
      return null;
    }
  }

  
  set is_no_timestamps(bool? value) {
    rawData["is_no_timestamps"] = value;
  }


  
  String? get audio {
    try {
      if (rawData["audio"] is String == false){
        return null;
      }
      return rawData["audio"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set audio(String? value) {
    rawData["audio"] = value;
  }


  
  String? get model {
    try {
      if (rawData["model"] is String == false){
        return null;
      }
      return rawData["model"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set model(String? value) {
    rawData["model"] = value;
  }


  
  static GetTextFromWavFile create({

    String special_type = "getTextFromWavFile",
    bool? is_translate,
    num? threads,
    bool? is_verbose,
    String? language,
    bool? is_special_tokens,
    bool? is_no_timestamps,
    String? audio,
    String? model,
})  {
    // GetTextFromWavFile getTextFromWavFile = GetTextFromWavFile({
Map getTextFromWavFile_data_create_json = {
  
      "@type": special_type,
      "is_translate": is_translate,
      "threads": threads,
      "is_verbose": is_verbose,
      "language": language,
      "is_special_tokens": is_special_tokens,
      "is_no_timestamps": is_no_timestamps,
      "audio": audio,
      "model": model,


};


          getTextFromWavFile_data_create_json.removeWhere((key, value) => value == null);
GetTextFromWavFile getTextFromWavFile_data_create = GetTextFromWavFile(getTextFromWavFile_data_create_json);

return getTextFromWavFile_data_create;



      }
}
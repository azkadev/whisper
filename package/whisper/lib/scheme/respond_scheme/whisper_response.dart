// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class WhisperResponse extends JsonScheme {

  
  WhisperResponse(super.rawData);
   
  static Map get defaultData {
    return {"@type":"whisperResponse","text":"","message":""};
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


  
  String? get text {
    try {
      if (rawData["text"] is String == false){
        return null;
      }
      return rawData["text"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set text(String? value) {
    rawData["text"] = value;
  }


  
  String? get message {
    try {
      if (rawData["message"] is String == false){
        return null;
      }
      return rawData["message"] as String;
    } catch (e) {
      return null;
    }
  }

  
  set message(String? value) {
    rawData["message"] = value;
  }


  
  static WhisperResponse create({

    String special_type = "whisperResponse",
    String? text,
    String? message,
})  {
    // WhisperResponse whisperResponse = WhisperResponse({
Map whisperResponse_data_create_json = {
  
      "@type": special_type,
      "text": text,
      "message": message,


};


          whisperResponse_data_create_json.removeWhere((key, value) => value == null);
WhisperResponse whisperResponse_data_create = WhisperResponse(whisperResponse_data_create_json);

return whisperResponse_data_create;



      }
}
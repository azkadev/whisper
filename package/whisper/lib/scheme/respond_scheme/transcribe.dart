// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class Transcribe extends JsonScheme {

  
  Transcribe(super.rawData);
   
  static Map get defaultData {
    return {"@type":"transcribe","text":""};
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


  
  static Transcribe create({

    String special_type = "transcribe",
    String? text,
})  {
    // Transcribe transcribe = Transcribe({
Map transcribe_data_create_json = {
  
      "@type": special_type,
      "text": text,


};


          transcribe_data_create_json.removeWhere((key, value) => value == null);
Transcribe transcribe_data_create = Transcribe(transcribe_data_create_json);

return transcribe_data_create;



      }
}
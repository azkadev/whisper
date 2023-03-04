// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class GetTextFromAudio extends JsonDart {

  
  GetTextFromAudio(super.rawData);
   
  static Map get defaultData {
    return {"@type":"getTextFromAudio","name":"","data":[1]};
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


  
  String? get name {
    try {
      if (rawData["name"] is String == false){
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }


  
  List<int> get data {
    try {
      if (rawData["data"] is List == false){
        return [];
      }
      return (rawData["data"] as List).cast<int>();
    } catch (e) {
      return [];
    }
  }


  
  static GetTextFromAudio create({

    String? special_type,
    String? name,
      List<int>? data,
})  {
    GetTextFromAudio getTextFromAudio = GetTextFromAudio({
  
      "@type": special_type,
      "name": name,
      "data": data,


  });


return getTextFromAudio;

      }
}
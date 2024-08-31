// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class TranscribeRealtime extends JsonScheme {

  
  TranscribeRealtime(super.rawData);
   
  static Map get defaultData {
    return {"@type":"transcribeRealtime"};
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


  
  static TranscribeRealtime create({

    String special_type = "transcribeRealtime",
})  {
    // TranscribeRealtime transcribeRealtime = TranscribeRealtime({
Map transcribeRealtime_data_create_json = {
  
      "@type": special_type,


};


          transcribeRealtime_data_create_json.removeWhere((key, value) => value == null);
TranscribeRealtime transcribeRealtime_data_create = TranscribeRealtime(transcribeRealtime_data_create_json);

return transcribeRealtime_data_create;



      }
}
// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class TranscribeSync extends JsonScheme {

  
  TranscribeSync(super.rawData);
   
  static Map get defaultData {
    return {"@type":"transcribeSync"};
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


  
  static TranscribeSync create({

    String special_type = "transcribeSync",
})  {
    // TranscribeSync transcribeSync = TranscribeSync({
Map transcribeSync_data_create_json = {
  
      "@type": special_type,


};


          transcribeSync_data_create_json.removeWhere((key, value) => value == null);
TranscribeSync transcribeSync_data_create = TranscribeSync(transcribeSync_data_create_json);

return transcribeSync_data_create;



      }
}
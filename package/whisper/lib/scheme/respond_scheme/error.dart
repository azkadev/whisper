// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class Error extends JsonScheme {

  
  Error(super.rawData);
   
  static Map get defaultData {
    return {"@type":"error","message":""};
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


  
  static Error create({

    String special_type = "error",
    String? message,
})  {
    // Error error = Error({
Map error_data_create_json = {
  
      "@type": special_type,
      "message": message,


};


          error_data_create_json.removeWhere((key, value) => value == null);
Error error_data_create = Error(error_data_create_json);

return error_data_create;



      }
}
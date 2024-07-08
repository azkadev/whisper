// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";


 
class Version extends JsonScheme {

  
  Version(super.rawData);
   
  static Map get defaultData {
    return {"@type":"version","message":""};
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


  
  static Version create({

    String special_type = "version",
    String? message,
})  {
    // Version version = Version({
Map version_data_create_json = {
  
      "@type": special_type,
      "message": message,


};


          version_data_create_json.removeWhere((key, value) => value == null);
Version version_data_create = Version(version_data_create_json);

return version_data_create;



      }
}
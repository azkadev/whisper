// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class GetTask extends JsonDart {

  
  GetTask(super.rawData);
   
  static Map get defaultData {
    return {"@type":"getTask","key":"","password":""};
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


  
  String? get key {
    try {
      if (rawData["key"] is String == false){
        return null;
      }
      return rawData["key"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get password {
    try {
      if (rawData["password"] is String == false){
        return null;
      }
      return rawData["password"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static GetTask create({

    String? special_type,
    String? key,
    String? password,
})  {
    GetTask getTask = GetTask({
  
      "@type": special_type,
      "key": key,
      "password": password,


  });


return getTask;

      }
}
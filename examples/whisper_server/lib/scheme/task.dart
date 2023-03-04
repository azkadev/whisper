// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class Task extends JsonDart {

  
  Task(super.rawData);
   
  static Map get defaultData {
    return {"@type":"task","key":"","password":"","expire_date":1677963112959};
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


  
  int? get expire_date {
    try {
      if (rawData["expire_date"] is int == false){
        return null;
      }
      return rawData["expire_date"] as int;
    } catch (e) {
      return null;
    }
  }


  
  static Task create({

    String? special_type,
    String? key,
    String? password,
    int? expire_date,
})  {
    Task task = Task({
  
      "@type": special_type,
      "key": key,
      "password": password,
      "expire_date": expire_date,


  });


return task;

      }
}
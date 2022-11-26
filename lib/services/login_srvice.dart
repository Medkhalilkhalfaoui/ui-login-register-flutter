import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/models/login_request_model.dart';
import 'package:user_login/config.dart';
import 'package:user_login/models/login_response_model.dart';

import '../pages/login_page.dart';

class LoginService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestMode model) async{
    Map<String,String> requestHeaders = {
      'Content-Type':'application/json',
    };
    var url =Uri.http(config.apiurl,config.loginapi);
    var response = await client.post(url,headers: requestHeaders,body: jsonEncode(model.toJson()));
    if(response.statusCode ==200){
      await setloginDetails(loginResponeJson(response.body));
      return true;

    }else{
      print("error");
      return false;
    }

  }
  static Future<bool> isLoggedIn() async{
    var iskeyExist = await APICacheManager().isAPICacheKeyExist("login_details");
    return iskeyExist;
  }

  static Future<LoginRespone?> logindetail() async{
    var iskeyExist = await APICacheManager().isAPICacheKeyExist("login_details");
    if(iskeyExist){
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponeJson(cacheData.syncData);
    }
  }

  static Future<void> setloginDetails(LoginRespone model)async{
    APICacheDBModel cacheDBModel = APICacheDBModel(key: "login_details", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);



  }
  static Future<void> logout() async{
    await APICacheManager().deleteCache("login_details");
    Get.offAll(()=>LoginPage());

  }


}
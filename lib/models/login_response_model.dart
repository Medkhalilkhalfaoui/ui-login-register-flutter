import 'dart:convert';

LoginRespone loginResponeJson(String str)=>LoginRespone.fromJson(json.decode(str));

class LoginRespone {
  LoginRespone({
    required this.token,
  });
  late final String token;

  LoginRespone.fromJson(Map<String, dynamic> json){
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}
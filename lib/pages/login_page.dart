import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:user_login/models/login_request_model.dart';
import 'package:user_login/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/pages/register_page.dart';

import '../services/login_srvice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;
  Future<String> login() async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),

      body: {
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
       var json = jsonDecode(response.body);
       print("kkf0");
       print(json);

      return json['token'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  Scaffold(
          backgroundColor: HexColor("#283871"),
          body: ProgressHUD(
            child: Form(
              key: globalKey,
              child: _loginUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
        )
    );
  }
  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4,
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ]
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/s.png",width: 250,fit: BoxFit.contain,),
                )

              ],
            ),
          ),
           const Padding(
             padding: const EdgeInsets.only(left: 20,bottom: 20,top: 50),
             child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white
              ),
          ),
           ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FormHelper.inputFieldWidget(
                context,
                "username",
                "Username",
                (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return "Username can't be empty";
                  }
                  return null;
                },
                (onSavedVal){

                  username = onSavedVal;
                },
               prefixIcon:const Icon(Icons.person_outline),
                showPrefixIcon: true,
               prefixIconColor: Colors.white,
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
                  (onValidateVal){
                if(onValidateVal.isEmpty){
                  return "Password can't be empty";
                }
                return null;
              },
                  (onSavedVal){

                  password = onSavedVal.toString();


              },
              prefixIcon:const Icon(Icons.currency_bitcoin),
              showPrefixIcon: true,
              prefixIconColor: Colors.white,
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      hidePassword=!hidePassword;
                    });
                  },
                  color: Colors.white.withOpacity(0.7),
                  icon: Icon(
                    hidePassword? Icons.visibility_off:Icons.visibility
                  )
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25,top: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                text:  TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(
                        text: 'Forget Pasword ?',
                        style:const  TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                          print("Forget password");
                        },
                    ),

                  ]
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
                "Login",
                (){
                  if(validateAndSave()){
                    print(username);
                    print(password);
                    var x = login() ;
                    print(x);

                   /* setState(() {
                      isAPIcallProcess = true;
                    });*/
                    //LoginRequestMode m = LoginRequestMode(username: username!, password: password!);
              /*      LoginService.login(m).then((response) {
                      setState(() {
                        isAPIcallProcess = false;
                      });
                      if(response){
                        Get.offAll(Home());
                      }else{
                        FormHelper.showSimpleAlertDialog(context, "app", "Invalid Username/Password !", "OK", (){Get.back();});
                      }
                    });*/
                  }
                },
                btnColor: HexColor("#283B71"),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10
            ),
          ),
          const SizedBox(height: 20,),
          const Center(
             child: Text(
              "or",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
              ),
          ),
           ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 25,top: 10),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text:  TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account ?"),
                      TextSpan(
                        text: ' Sign Up',
                        style:const  TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Get.to(()=> RegisterPage());
                          },
                      ),

                    ]
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

}

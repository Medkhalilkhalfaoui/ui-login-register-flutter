import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  Scaffold(
          backgroundColor: HexColor("#283871"),
          body: ProgressHUD(
            child: Form(
              key: globalKey,
              child: _registerUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
        )
    );
  }
  Widget _registerUI(BuildContext context){
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
            padding:  EdgeInsets.only(left: 20,bottom: 20,top: 50),
            child: Text(
              "Register",
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
              "email",
              "Email",
                  (onValidateVal){
                if(onValidateVal.isEmpty){
                  return "Email can't be empty";
                }
                return null;
              },
                  (onSavedVal){
                email = onSavedVal;
              },
              prefixIcon:const Icon(Icons.email),
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
                  password = onSavedVal;
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

          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
                "Register",
                    (){},
                btnColor: HexColor("#283B71"),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10
            ),
          ),




        ],
      ),
    );
  }
}

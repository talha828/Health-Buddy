import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/signup_screen/view.dart';
import 'package:health_buddy/widgets/health_button.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:health_buddy/widgets/health_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  String login="Login Now";
  bool? checkBox =true;
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                height: height,
                padding: EdgeInsets.all(width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/image/login.svg",width: width * 0.4,height: width * 0.4,),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.redAccent,
                          fontWeight: FontWeight.bold, fontSize: width * 0.08),
                    ),
                    HealthTextField(email: email, login: "Email", width: width),
                    HealthTextField(email: email, login: "Password", width: width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: checkBox, onChanged: (value){
                              setState(() {
                                checkBox=value;
                              });
                            }),
                            Text("Remember Me?")
                          ],
                        ),
                        Text("Forget Password?")
                      ],
                    ),
                    HealthButton(width: width, login: login),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Create New Account?  ",style: TextStyle(color: Colors.grey),),
                        InkWell(
                            onTap: ()=>Get.to(const SignUpScreen()),
                            child:const Text("SignUp",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            isLoading?const Positioned.fill(child: LoadingIndicator()):Container()
          ],
        ),
      ),
    );
  }
}


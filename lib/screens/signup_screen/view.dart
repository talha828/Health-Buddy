import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/login_screen/view.dart';
import 'package:health_buddy/widgets/health_button.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:health_buddy/widgets/health_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name=TextEditingController();
  bool isLoading= true;
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
                    SvgPicture.asset("assets/image/signUp.svg",width: width * 0.4,height: width * 0.4,),
                    Text(
                      "SignUp",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold, fontSize: width * 0.08),
                    ),
                    HealthTextField(email: name, login: "Name", width: width),
                    HealthTextField(email: name, login: "Email", width: width),
                    HealthTextField(email: name, login: "Password", width: width),
                    HealthTextField(email: name, login: "Confirm Password", width: width),
                    HealthButton(width: width, login: "SignUp Now"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Register?  ",style: TextStyle(color: Colors.grey),),
                        InkWell(
                            onTap: ()=>Get.to(const SignUpScreen()),
                            child:const Text("SignIn",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
                      ],
                    )

                  ],
                ),
              ),
            ),
            isLoading?const Positioned.fill(child:LoadingIndicator()):Container()
          ],
        ),
      ),
    );
  }
}

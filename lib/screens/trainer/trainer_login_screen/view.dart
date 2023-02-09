import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/firebase/database.dart';
import 'package:health_buddy/screens/common/signup_screen/view.dart';
import 'package:health_buddy/screens/trainer/signup_screen/view.dart';
import 'package:health_buddy/widgets/health_button.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:health_buddy/widgets/health_text_field.dart';

class TrainerLoginScreen extends StatefulWidget {
  const TrainerLoginScreen({Key? key}) : super(key: key);

  @override
  State<TrainerLoginScreen> createState() => _TrainerLoginScreenState();
}

class _TrainerLoginScreenState extends State<TrainerLoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String login = "Login Now";
  bool? checkBox = true;
  bool isLoading = false;
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        "assets/image/login.svg",
                        width: width * 0.4,
                        height: width * 0.4,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.08),
                      ),
                      HealthTextField(
                        email: email,
                        width: width,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                        hintText: "Email",
                      ),
                      HealthTextField(
                        email: password,
                        width: width,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                        hintText: "Password",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: checkBox,
                                  onChanged: (value) {
                                    setState(() {
                                      checkBox = value;
                                    });
                                  }),
                              Text(
                                "Remember Me?",
                                style: TextStyle(fontSize: width * 0.035),
                              )
                            ],
                          ),
                          Text(
                            "Forget Password?",
                            style: TextStyle(fontSize: width * 0.035),
                          )
                        ],
                      ),
                      HealthButton(
                          width: width,
                          login: login,
                          onTap: ()async{
                            setLoading(true);
                            if(_formKey.currentState!.validate()){
                              await Database.trainerLogin(email.text, password.text.toString()).then((value) => setLoading(false)).catchError((e){
                                setLoading(false);
                                print(e.message.toString());
                                Fluttertoast.showToast(msg: "Error: ${e.message}");
                              });
                            }
                          }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Create New Account?  ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () => Get.to(const TrainerSignUpScreen()),
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            isLoading ?const Positioned.fill(child: LoadingIndicator()) : Container()
          ],
        ),
      ),
    );
  }
}

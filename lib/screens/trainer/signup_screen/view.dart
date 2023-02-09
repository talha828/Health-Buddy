import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/controller/trainer_details_controller.dart';
import 'package:health_buddy/firebase/database.dart';
import 'package:health_buddy/screens/trainer/trainer_details_screen/view.dart';
import 'package:health_buddy/screens/trainer/trainer_login_screen/view.dart';
import 'package:health_buddy/widgets/health_button.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:health_buddy/widgets/health_text_field.dart';

import '../../common/login_screen/view.dart';

class TrainerSignUpScreen extends StatefulWidget {
  const TrainerSignUpScreen({Key? key}) : super(key: key);

  @override
  State<TrainerSignUpScreen> createState() => _TrainerSignUpScreenState();
}

class _TrainerSignUpScreenState extends State<TrainerSignUpScreen> {

  final trainer=Get.put(TrainerDetailsController());

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: height,
                padding: EdgeInsets.all(width * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        "assets/image/signUp.svg",
                        width: width * 0.4,
                        height: width * 0.4,
                      ),
                      Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.08),
                      ),
                      HealthTextField(
                        email: name,
                        width: width,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        hintText: "Name",
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
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        hintText: "Password",
                      ),
                      HealthTextField(
                        email: confirmPassword,
                        width: width,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Confirm Password';
                          }
                          return null;
                        },
                        hintText: "Confirm Password",
                      ),
                      HealthButton(width: width, login: "Next",onTap: ()async{

                        // setLoading(true);
                        if (_formKey.currentState!.validate()) {
                          if(password.text==confirmPassword.text){
                            trainer.name.value=name.text;
                            trainer.email.value=email.text;
                            trainer.password.value=password.text;
                            Get.to(const TrainerDetailsScreen());
                          }else{
                            Fluttertoast.showToast(msg: "Your Password not match").then((value) => setLoading(false));
                          }
                        }else{
                          // setLoading(false);
                        }
                      },),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already Register?  ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () =>Get.to(()=>const TrainerLoginScreen()),
                            child: const Text(
                              "SignIn",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? const Positioned.fill(child: LoadingIndicator())
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}


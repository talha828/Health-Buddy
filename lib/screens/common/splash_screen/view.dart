import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/firebase/database.dart';
import 'package:health_buddy/screens/common/get_start_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/login_screen/view.dart';
import '../../user/main_screen/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getStart() async {
    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var type = prefs.getString("type");
    var password = prefs.getString("password");
    if (email.toString() != "null" && password.toString() != "null") {
      if(type =="user"){
        await Database.login(email.toString(), password.toString())
            .then((value) => Get.to(() => const MainScreen()))
            .catchError(
          (e) {
            print(e.message);
            Fluttertoast.showToast(msg: "Error: ${e.message}");
          },
        );
      }else{
        await Database.trainerLogin(email.toString(), password.toString()).then((value){}).catchError((e){
          print(e.message.toString());
          Fluttertoast.showToast(msg: "Error: ${e.message}");
        });
      }
    } else {
      Timer(const Duration(seconds: 2), () => Get.to(const GetStartScreen()));
    }
  }
  
  @override
  void initState() {
    super.initState();
    getStart();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/logo/logo.png",
            width: width * 0.35,
            height: width * 0.35,
          ),
          SizedBox(
            height: width * 0.08,
          ),
          Text(
            "Health Buddy",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: width * 00.07,
                letterSpacing: width * 0.007,
                fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/login_screen/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),()=>Get.to(LoginScreen()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/logo/logo.png",width: width * 0.35,height: width * 0.35,),
              SizedBox(height: width * 0.08,),
              Text("Health Buddy",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: width * 00.07,
                  letterSpacing: width * 0.007,
                  fontWeight: FontWeight.bold
              ),)
            ],
          )
      ),
    );
  }
}

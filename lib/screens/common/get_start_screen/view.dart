import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:health_buddy/generated/assets.dart';
import 'package:health_buddy/screens/common/login_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../trainer/trainer_login_screen/view.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  var onTap = () {};
  String label = "Trainer";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.04, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: SvgPicture.asset(
                Assets.imageGetStart,
                width: width,
                height: width,
              ),
            ),
            Text(
              "Welcome To ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            Text(
              "Health Buddy App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            Text(
              "Welcome to our app here you can get you trainers for gym and other activates also we earn as a trainer, also you can make friends and have lots of fun",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            HeathButton(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("type", "user");
                  Get.to(const LoginScreen());
                },
                width: width,
                label: "I want Trainer"),
            SizedBox(
              height: width * 0.06,
            ),
            HeathButton(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("type", "trainer");
                  Get.to(const TrainerLoginScreen());
                },
                width: width,
                label: "I am Trainer"),
          ],
        ),
      ),
    );
  }
}

class HeathButton extends StatelessWidget {
  const HeathButton({
    Key? key,
    required this.onTap,
    required this.width,
    required this.label,
  }) : super(key: key);

  final Function() onTap;
  final double width;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(7)),
        child: Text(
          label,
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

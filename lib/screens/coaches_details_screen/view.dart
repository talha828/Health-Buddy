import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoachesDetailsScreen extends StatefulWidget {
  const CoachesDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CoachesDetailsScreen> createState() => _CoachesDetailsScreenState();
}

class _CoachesDetailsScreenState extends State<CoachesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 1.toString(),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.09, horizontal: width * 0.09),
                color: Colors.red,
                height: width,
                child: SvgPicture.asset(
                  "assets/image/signUp.svg",
                  width: width,
                  height: width,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.09, horizontal: width * 0.09),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 1500),
                      builder: (context, double value, child) {
                        return Text(
                          "Talha Iqbal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.07,
                            color: Colors.black.withOpacity(value),
                          ),
                        );
                      }),
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.09, end: 0.07),
                      duration: Duration(milliseconds: 1500),
                      builder: (context, double value, child) {
                        return SizedBox(
                          height: width * value,
                        );
                      }),
                  TweenAnimationBuilder(  
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 1000),
                      builder: (context, double value, child) {
                        return Text(
                          "A Hello, World! program is generally a computer program that ignores any input and outputs or displays a message similar to Hello, World!. A small piece of code in most general-purpose programming languages, this program is used to illustrate a language's basic syntax. Hello, World! programs are often the first a student learns to write in a given language,[1] and they can also be used as a sanity check to ensure computer software intended to compile or run source code is correctly installed, and that its operator understands how to use it.",
                          style: TextStyle(color: Colors.grey.shade600.withOpacity(value)),
                        );
                      }),
                  SizedBox(
                    height: width * 0.07,
                  ),
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 1000),
                      builder: (context, double value, child) {
                        return Text(
                          "Karachi, Pakistan",
                          style: TextStyle(color: Colors.grey.shade600.withOpacity(value)),
                        );
                      }),
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.09, end: 0.07),
                      duration: Duration(milliseconds: 1500),
                      builder: (context, double value, child) {
                        return SizedBox(
                          height: width * value,
                        );
                      }),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                        color: Colors.red,
                         borderRadius: BorderRadius.circular(width * 0.01)
                        ),
                        padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                        child: Row(
                          children: [
                            Text("Chat Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            SizedBox(width: width * 0.02,),
                            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: width * 0.05,)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

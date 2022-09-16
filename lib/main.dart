import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_buddy/screens/splash_screen/view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.red)),
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        primaryTextTheme:
            GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}

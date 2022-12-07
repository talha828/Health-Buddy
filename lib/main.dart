import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_buddy/screens/chat_room_screen/view.dart';
import 'package:health_buddy/screens/gym_buddies_screen/view.dart';
import 'package:health_buddy/screens/splash_screen/view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   Stripe.publishableKey = 'pk_test_51MCMhyIdD40UeF5nIOBmzIP897tYKj76kAWghlgMHAFER3HcCwjkajVNu5KvjGbSAXHM3uFjrCT79sERcPw70SHR00Jkgdl8WH';
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Stripe.instance.applySettings();
  // Stripe.merchantIdentifier = 'any string works';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.red)),
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        primaryTextTheme:
            GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:health_buddy/screens/main_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database{
  static Future<bool>signUp(String name,String email,String password,)async{
    FirebaseAuth auth=FirebaseAuth.instance;
    DatabaseReference database=FirebaseDatabase.instance.ref().child("database").child("user_details");
    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)async {
      await database.child(value.user!.uid).set({
        "name":name,
        "email":email,
        "password":password,
      }).then((value) async{
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("password", password);
        Get.to(const MainScreen());});
    }).catchError((e){Fluttertoast.showToast(msg: "something went wrong");});
    return true;
  }
  static Future<bool>login(String email,String password,)async{
    FirebaseAuth auth=FirebaseAuth.instance;
    DatabaseReference database=FirebaseDatabase.instance.ref().child("database").child("user_details");
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value)async{
      var snapshot=await database.child(value.user!.uid).once();
      if (snapshot.snapshot.exists){
        print(snapshot.snapshot.value);
        List <String> list=[];
        var data=snapshot.snapshot.children.forEach((element) {
          list.add(element.value.toString());
        });
        final user=Get.put(UserDetails());
        user.name.value= list[0];
        user.email.value= list[1];
        user.uid.value= value.user!.uid.toString();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email",list[0]);
        prefs.setString("password", list[2]);
        Get.to(()=>const MainScreen());
      } else {
        print('No data available.');
      }
    });
    return true;
  }
}
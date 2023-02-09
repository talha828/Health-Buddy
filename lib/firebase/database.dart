import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/controller/trainer_details_controller.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:health_buddy/screens/trainer/dashboard_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/user/main_screen/view.dart';

class Database{
  static Future<bool>signUp(String name,String email,String password,)async{
    var database=FirebaseFirestore.instance.collection("users_personal_info");
    FirebaseAuth _auth=FirebaseAuth.instance;
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value)async {
      await database.doc(_auth.currentUser!.uid).set({
        "name":name,
        "email":email,
        "password":password,
      }).then((value) async{
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);

        Get.to(const MainScreen());});
    }).catchError((e){
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");});
    return true;
  }
  static Future<bool>login(String email,String password,)async{
    FirebaseAuth auth=FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value)async{
      var database=FirebaseFirestore.instance.collection("users_personal_info");
      var snapshot=await database.doc(auth.currentUser!.uid).get();
      Map? data= snapshot.data();
      if (data!.isNotEmpty){
        final user=Get.put(UserController());
        user.name.value= data['name'];
        user.email.value= data['email'];
        user.uid.value= value.user!.uid.toString();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email",data['email']);
        prefs.setString("password",data['password']);
        Get.to(()=>const MainScreen());
      } else {
        print('No data available.');
      }
    });
    return true;
  }
  static Future<bool> createPost(PostController  createPostDetails)async{
    FirebaseAuth auth= FirebaseAuth.instance;
    var database = FirebaseFirestore.instance.collection("activity_posts");
    var stamp=DateTime.now().microsecondsSinceEpoch;
    await database
        .doc(createPostDetails.type.value)
        .collection(createPostDetails.type.value)
        .doc(stamp.toString())
        .set({
      "name": createPostDetails.userName.value,
      "type": createPostDetails.type.value,
      "uid":auth.currentUser!.uid,
      "fromAddress": createPostDetails.fromAddress.value,
      "toAddress": createPostDetails.toAddress.value,
      "fromTime": createPostDetails.fromTime.value.toString(),
      "toTime": createPostDetails.toTime.value.toString(),
      "fromLatLong": GeoPoint(
          createPostDetails.fromLatLong.value.latitude,
          createPostDetails.fromLatLong.value.longitude),
      "toLatLong": GeoPoint(
          createPostDetails.toLatLong.value.latitude,
          createPostDetails.toLatLong.value.longitude),
      "timestamp": stamp,
      "followers":0,
    });
    return true;
  }
  static Future<bool>signUpTrainer(File file)async{
    final trainer=Get.find<TrainerDetailsController>();
    var database=FirebaseFirestore.instance.collection("trainer_personal_info");
    FirebaseAuth _auth=FirebaseAuth.instance;
    await _auth.createUserWithEmailAndPassword(email: trainer.email.value, password: trainer.password.value).then((value)async {
      await database.doc(_auth.currentUser!.uid).set({
        "name":trainer.name.value,
        "email":trainer.email.value,
        "password":trainer.password.value,
        "nickName":trainer.nickName.value,
        "bio":trainer.bio.value,
        "address":trainer.address.value,
        "country":trainer.country.value,
        "trainerType":trainer.trainerType.value,
        "image":Blob(file.readAsBytesSync()),
      }).then((value) async{
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email", trainer.email.value);
        prefs.setString("password", trainer.password.value);
        prefs.setString("password", trainer.password.value);
        Get.to(const DashboardScreen());
      return true;
      });
    }).catchError((e){
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      return;
    });
    return true;
  }
  static Future<bool>trainerLogin(String email,String password,)async{
    FirebaseAuth auth=FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value)async{
      var database=FirebaseFirestore.instance.collection("trainer_personal_info");
      var snapshot=await database.doc(auth.currentUser!.uid).get();
      Map? data= snapshot.data();
      if (data!.isNotEmpty){
        final trainer=Get.put(TrainerDetailsController());
        trainer.name.value= data['name'];
        trainer.email.value= data['email'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email",data['email']);
        prefs.setString("password",data['password']);
        Get.to(()=>const DashboardScreen());
      } else {
        print('No data available.');
      }
    });
    return true;
  }
}
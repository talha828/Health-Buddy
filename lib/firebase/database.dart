import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:health_buddy/screens/main_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        prefs.setString("password", password);
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
        final user=Get.put(UserDetails());
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
  static Future<bool> createPost(CreatePost  createPostDetails)async{
    FirebaseAuth auth= FirebaseAuth.instance;
    var database = FirebaseFirestore.instance.collection("posts");
    await database
        .doc(createPostDetails.type.value)
        .collection(createPostDetails.type.value)
        .doc()
        .set({
      "name": createPostDetails.name.value,
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
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    return true;
  }

}
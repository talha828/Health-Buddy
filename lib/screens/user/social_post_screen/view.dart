import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/user_model.dart';


class CreateSocialPostScreen extends StatefulWidget {
  const CreateSocialPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateSocialPostScreen> createState() => _CreateSocialPostScreenState();
}

class _CreateSocialPostScreenState extends State<CreateSocialPostScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  bool isImage=false;
  late File image;
  final userController=Get.find<UserController>();


  postData()async{
    var database=FirebaseFirestore.instance.collection("posts");
    database.doc().set({
      "name":userController.name.value,
      "email":userController.email.value,
      "uid":userController.uid.value,
      "text":_controller.text.trim(),
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "like":0,
      "image":Blob(image.readAsBytesSync()),
    }).then((value) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Congratulation',
        desc: 'Your post successfully created',
        btnOkColor: Colors.red,
        btnOkOnPress: () {
          Navigator.of(context)..pop();
        },
      )
        .show();
    }).catchError((e){
      Fluttertoast.showToast(msg: "Something went wrong");
    });

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post",
          style: TextStyle(color: Colors.red),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
        color: Colors.white,
        child: ElevatedButton(onPressed: (){
          if(image != null){
            if(_controller.text.isNotEmpty){
              postData();
            }else{
            Fluttertoast.showToast(msg: "Share your thoughts..");
            }
          }else{
            Fluttertoast.showToast(msg: "Image Not Found");
          }
        },child:const Text("Publish"),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: width * 0.04,
              ),
              TextField(
                maxLines: 7,
                controller: _controller,
                decoration: const InputDecoration(
                  label: Text("Share Your thoughts..."),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  alignLabelWithHint: true
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              InkWell(
                onTap: ()async{
                  final XFile? value = await _picker.pickImage(source: ImageSource.gallery);
                  if(value!.path != null){
                    image=File(value!.path);
                    isImage=true;
                    setState(() {});
                  }
                },
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child:isImage?Image.memory(image.readAsBytesSync(),fit: BoxFit.contain,): Column(
                    children: [
                      SizedBox(height: width * 0.1,),
                      Image.asset("assets/image/social-media.png",width: width * 0.4,height: width * 0.4,),
                      SizedBox(height: width * 0.04,),
                      Text("Select Image with Gallery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                      SizedBox(height: width * 0.04,),
                      Text("Attach Image with your documents so your post looks more Attractive",textAlign: TextAlign.center,style: TextStyle(color:Colors.grey,fontSize: width * 0.03),),
                      SizedBox(height: width * 0.04,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

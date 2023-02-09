import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/health_loading_indicator.dart';

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({Key? key}) : super(key: key);

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen> {
  final TextEditingController _controller = TextEditingController();
  bool flag = false;
  late File file;
  late PlatformFile data;
  final ImagePicker _picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;
  final userController=Get.find<UserController>();

  bool isLoading=false;

  setLoading(bool value)=>setState(()=>isLoading=value);

  Future uploadToStorage() async {
    setLoading(true);
    try {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId =
          (millSeconds.toString() + auth.currentUser!.uid);
      final String today = ('$month-$date');

      // final XFile? file=  await _picker.pickVideo(source: ImageSource.gallery,maxDuration:const Duration(seconds: 90));

      var ref = FirebaseStorage.instance
          .ref()
          .child("video")
          .child(today)
          .child(storageId);
      var uploadTask = await ref.putFile(
          file,
          SettableMetadata(
            contentType: 'video/mp4',
          ),);
      var url = await ref.getDownloadURL();
      print(url.toString());
      print(storageId);

      var database=FirebaseFirestore.instance.collection("video");
      database.doc().set({
        "name":userController.name.value,
        "email":userController.email.value,
        "uid":userController.uid.value,
        "text":_controller.text.trim(),
        "timestamp":DateTime.now().microsecondsSinceEpoch,
        "like":0,
        "video":url,
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
        setLoading(false);
          },
        )
            .show();
      }).catchError((e){
        setLoading(false);
        Fluttertoast.showToast(msg: "Something went wrong");
      });


    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  late XFile xFile;
  getFile() async {
    final XFile? result = await _picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 120));
    if (result != null) {
      setState(() {
        xFile = result;
        file = File(result.path);
        flag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Reels",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: height,
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
                        alignLabelWithHint: true),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  InkWell(
                    onTap: () => getFile(),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: flag
                          ? Column(
                              children: [
                                SizedBox(
                                  height: width * 0.1,
                                ),
                                Image.asset(
                                  "assets/image/reels.png",
                                  width: width * 0.4,
                                  height: width * 0.4,
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.06),
                                  child: Text(
                                    "${xFile.name}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05),
                                  ),
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: width * 0.1,
                                ),
                                Image.asset(
                                  "assets/image/rating.png",
                                  width: width * 0.4,
                                  height: width * 0.4,
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                Text(
                                  "Select Image with Gallery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05),
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                Text(
                                  "Attach Image with your documents so your post looks more Attractive",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: width * 0.03),
                                ),
                                SizedBox(
                                  height: width * 0.04,
                                ),
                              ],
                            ),
                    ),
                  ),
                  //const Spacer(),

                  SizedBox(
                    height: width * 0.07,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                    // color: Colors.white,
                    child: ElevatedButton(onPressed: (){
                      if(file != null){
                        if(_controller.text.isNotEmpty){
                          uploadToStorage();
                        }else{
                          Fluttertoast.showToast(msg: "Share your thoughts..");
                        }
                      }else{
                        Fluttertoast.showToast(msg: "video Not Found");
                      }
                    },child:const Text("Publish"),),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? const Positioned.fill(child: LoadingIndicator())
              : Container()
        ],
      ),
    );
  }
}

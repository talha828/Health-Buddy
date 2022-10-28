import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/create_post_model.dart';

class ConfirmPostScreen extends StatefulWidget {
  const ConfirmPostScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPostScreen> createState() => _ConfirmPostScreenState();
}

class _ConfirmPostScreenState extends State<ConfirmPostScreen> {
  var database=FirebaseFirestore.instance.collection("posts");
  FirebaseAuth _auth=FirebaseAuth.instance;
  final createPostDetails=Get.find<CreatePost>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Confirm your post",
            style: TextStyle(color: Colors.red),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(width *0.02),
                      border: Border.all(color: Colors.red,width: 2)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            //TODO:// Change type to name
                            Text(createPostDetails.name.value,textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child:Text(createPostDetails.type.value,style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        const Divider(color: Colors.red,),
                        Row(
                          children: [
                            Text("From",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Text(createPostDetails.fromAddress.value),
                        SizedBox(height: width * 0.02),
                        Row(
                          children: [
                            Text("To",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Text(createPostDetails.toAddress.value),
                        const Divider(color: Colors.red,),
                        Row(
                          children: [
                            Text("Timings",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child: Text(createPostDetails.fromTime.value.hour.toString()+":"+createPostDetails.fromTime.value.minute.toString(),style: TextStyle(color: Colors.white),),
                            ),
                            Text("To",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child: Text(createPostDetails.toTime.value.hour.toString()+":"+createPostDetails.toTime.value.minute.toString(),style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.red,),
                        SizedBox(height: width * 0.02),
                        InkWell(
                          onTap: ()async{
                            await database.doc(createPostDetails.type.value).collection(createPostDetails.type.value).doc().set({
                              "name":createPostDetails.name.value,
                              "type":createPostDetails.type.value,
                              "fromAddress":createPostDetails.fromAddress.value,
                              "toAddress":createPostDetails.toAddress.value,
                              "fromTime":createPostDetails.fromTime.value.toString(),
                              "toTime":createPostDetails.toTime.value.toString(),
                              "fromLatLong":GeoPoint(createPostDetails.fromLatLong.value.latitude,createPostDetails.fromLatLong.value.longitude),
                              "toLatLong":GeoPoint(createPostDetails.toLatLong.value.latitude,createPostDetails.toLatLong.value.longitude),
                              "timestamp":DateTime.now().microsecondsSinceEpoch
                            }).then((value) =>AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Congratulation',
                              desc: 'Your post successfully created',
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {},
                            )..show());

                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                            padding: EdgeInsets.symmetric(vertical: width  * 0.02,horizontal: width *0.04),
                              child:Text("Post Now",style: TextStyle(color: Colors.white),)),
                        ),
                        SizedBox(height: width * 0.02),

                      ],
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

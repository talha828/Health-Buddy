import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class WatchPostsScreen extends StatefulWidget {
  const WatchPostsScreen({Key? key}) : super(key: key);

  @override
  State<WatchPostsScreen> createState() => _WatchPostsScreenState();
}

class _WatchPostsScreenState extends State<WatchPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Post",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: width * 0.02),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .orderBy("timestamp")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Blob image = snapshot.data!.docs[index]['image'];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                          decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(color: Colors.black54, blurRadius: 7)
                              // ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    snapshot.data!.docs[index]['name']
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['name'].toString().toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text(snapshot.data!.docs[index]['email']),
                                trailing: const Icon(Icons.more_horiz),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: Text(
                                  snapshot.data!.docs[index]['text'],
                                  style: TextStyle(fontSize: width * 0.035),
                                ),
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              ClipRRect(
                                borderRadius:const  BorderRadius.only(bottomLeft:Radius.circular(7),bottomRight:Radius.circular(7), ),
                                child: Image.memory(
                                  image.bytes,
                                  height: width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      FirebaseFirestore.instance.collection("posts").doc(snapshot.data!.docs[index].id).update({
                                        "like":1 + int.parse(snapshot.data!.docs[index]['like'].toString())
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.04),
                                      child: Row(
                                        children: [
                                          Text("${snapshot.data!.docs[index]['like']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                                          SizedBox(width: width * 0.02,),
                                          Image.asset("assets/image/like.png",width: 25,height: 25,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:()async{
                                      File file=File.fromRawPath(image.bytes);
                                        bool save  =await ImageGallerySaver.saveImage(image.bytes);
                                        if(save){
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.rightSlide,
                                            title: 'Congratulation',
                                            desc: 'Your post successfully created',
                                            btnOkColor: Colors.red,
                                            btnOkOnPress: () {},
                                          )
                                            .show();
                                        }else{
                                          Fluttertoast.showToast(msg: "Somethings went wrong");
                                        }

                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.04),
                                      child: Image.asset("assets/image/cloud-computing.png",width: 25,height: 25,),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: width * 0.04,
                        );
                      },
                      itemCount: snapshot.data!.docs.length);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

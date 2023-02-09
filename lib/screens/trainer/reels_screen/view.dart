import 'package:better_video_player/better_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/trainer/create_reels_screen/view.dart';
import 'package:health_buddy/screens/user/create_reel_screen/view.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () =>Get.back(),
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
                SizedBox(height: width * 0.04,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.red)
                  ),
                  child: ListTile(
                    onTap: ()async{
                          Get.to(const TrainerCreateReelScreen());
                    },
                    leading:const Icon(Icons.add,color: Colors.red,),
                    title:const Text("Add Reels",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: width * 0.04,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("video")
                      .orderBy("timestamp")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (ConnectionState.waiting == snapshot.connectionState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //Blob image = snapshot.data!.docs[index]['image'];
                          return Container(
                            margin:
                            EdgeInsets.symmetric(horizontal: width * 0.04),
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
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
                                    snapshot.data!.docs[index]['name']
                                        .toString()
                                        .toUpperCase(),
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
                                Container(
                                  height: 500,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 16.0 / 9.0,
                                        child: BetterVideoPlayer(
                                          controller:
                                          BetterVideoPlayerController(),
                                          dataSource: BetterVideoPlayerDataSource(
                                            BetterVideoPlayerDataSourceType
                                                .network,
                                            snapshot.data!.docs[index]['video'],
                                          ),
                                          configuration:
                                          const BetterVideoPlayerConfiguration(
                                            autoPlay: false,
                                            //looping: true,
                                          ),
                                        ),
                                      )),
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
      ),
    );
  }
}

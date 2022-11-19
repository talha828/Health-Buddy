import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:health_buddy/widgets/health_follow_me_card.dart';
import 'package:health_buddy/widgets/healty_create_post_card.dart';

import '../activity_posts/show_route_screen/view.dart';

class ViewPostsScreen extends StatefulWidget {
  const ViewPostsScreen({Key? key}) : super(key: key);

  @override
  State<ViewPostsScreen> createState() => _ViewPostsScreenState();
}

class _ViewPostsScreenState extends State<ViewPostsScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance
        .collection('activity_posts')
        .doc("Gym Buddy")
        .collection("Gym Buddy");
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: const Icon(
                Icons.notifications_none_outlined,
              color: Colors.white,
              ),
            )
          ],
          title: const Center(
            child: Text(
              "Gym Buddy",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: StreamBuilder(
            stream: posts.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) // TODO: show alert
                  {
                return const Text('Something went wrong');
              }
              if (snapshot.hasData && snapshot.data!.docs.length < 1) {
                return const  Center(child: Text("No post is available",style: TextStyle(color: Colors.grey),));
              }
              List<CreatePostModel> msg = snapshot.data!.docs
                  .map(
                    (doc) => CreatePostModel(
                      name: doc["name"],
                      type: doc["type"],
                      fromAddress: doc["fromAddress"],
                      toAddress: doc["toAddress"],
                      fromTime: convertTime(int.parse(doc["fromTime"])),
                      toTime: convertTime(int.parse(doc["toTime"])),
                      fromLatLong: doc["fromLatLong"],
                      toLatLong: doc["toLatLong"],
                      timestamp: doc["timestamp"],
                    ),
                  )
                  .toList();
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: width * 0.04,
                  );
                },
                itemCount: msg.length,
                itemBuilder: (context, index) {
                  return FollowMeCard(
                    width: width,
                    showRoute: () => Get.to(
                      ShowRouteScreen(
                        currentPosition: LatLng(msg[index].toLatLong.latitude,
                            msg[index].toLatLong.longitude),
                        targetPosition: LatLng(msg[index].fromLatLong.latitude,
                            msg[index].fromLatLong.longitude),
                      ),
                    ),
                    createPostDetails: msg[index],
                    follow: (){

                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
  String convertTime(int timestamp)=> f.format(DateTime.fromMillisecondsSinceEpoch(timestamp)).substring(0,16);
}

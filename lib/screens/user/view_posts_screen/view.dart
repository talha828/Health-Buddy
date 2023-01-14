import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:health_buddy/screens/user/activity_posts/show_route_screen/view.dart';
import 'package:health_buddy/widgets/health_follow_me_card.dart';
import 'package:health_buddy/widgets/healty_create_post_card.dart';
import '../activity_posts/set_current_location_screen/view.dart';


class ViewPostsScreen extends StatefulWidget {
  const ViewPostsScreen({Key? key,required this.type}) : super(key: key);
  final String type;
  @override
  State<ViewPostsScreen> createState() => _ViewPostsScreenState();
}

class _ViewPostsScreenState extends State<ViewPostsScreen> {
  final controller= Get.put(PostController());
  final userController=Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    var posts = FirebaseFirestore.instance
        .collection('activity_posts')
        .doc(widget.type)
        .collection(widget.type).orderBy("timestamp",descending: true);
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
          title: Center(
            child: Text(
              widget.type,
              style:const TextStyle(color: Colors.red),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.03),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border:Border.all(color:Colors.grey)
                ),
                child:  ListTile(
                  onTap: (){
                    // TODO:// set post
                    controller.type.value=widget.type;
                    controller.userName.value=userController.name.value;
                    Get.to(const SetCurrentLocationScreen());
                  },
                  leading:const Icon(Icons.add),
                  title:const Text("Create New Post"),
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: posts.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) // TODO: show alert
                        {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.hasData && snapshot.data!.docs.length < 1) {
                      return Container(
                          alignment: Alignment.center,
                          child:const Text("No post is available",style: TextStyle(color: Colors.grey),));
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
                            followers: doc['followers']
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
                              startPosition: LatLng(msg[index].toLatLong.latitude,
                                  msg[index].toLatLong.longitude),
                              endPosition: LatLng(msg[index].fromLatLong.latitude,
                                  msg[index].fromLatLong.longitude),
                            ),
                          ),
                          createPostDetails: msg[index],
                          follow: (){
                            FirebaseFirestore.instance.collection('activity_posts').doc(widget.type).collection(widget.type).doc(msg[index].timestamp.toString()).update({'followers': msg[index].followers +1}).then((value) =>  AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Congratulation',
                              desc: 'Your are added in followers',
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {
                              },
                            )
                              ..show());
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String convertTime(int timestamp)=> f.format(DateTime.fromMillisecondsSinceEpoch(timestamp)).substring(0,16);
}

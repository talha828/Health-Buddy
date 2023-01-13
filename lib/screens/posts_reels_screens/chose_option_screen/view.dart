import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/posts_reels_screens/watch_posts/view.dart';
import 'package:health_buddy/screens/social_post_screen/view.dart';

class ChoseOptionScreen extends StatefulWidget {
  const ChoseOptionScreen({Key? key}) : super(key: key);

  @override
  State<ChoseOptionScreen> createState() => _ChoseOptionScreenState();
}

class _ChoseOptionScreenState extends State<ChoseOptionScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Create Post",
            style: TextStyle(color: Colors.red),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            children: [
              // watch posts
              ListTile(
                onTap: (){
                  Get.to(const WatchPostsScreen());
                },
                leading: Image.asset("assets/image/social-media.png",scale: 12,),
                title: Text(
                  "Posts / Trends",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
                subtitle:const Text("Watch trending activity_posts"),
                trailing:const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Divider(),
              //create posts
              ListTile(
                onTap: ()=>Get.to(const CreateSocialPostScreen()),
                leading: Image.asset(
                  "assets/image/new-post.png",
                  scale: 15,
                ),
                title: Text(
                  "Create Posts",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
                subtitle:const Text("Share your journey with friends"),
                trailing:const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Divider(),
              // watch reels
              ListTile(
                leading: Image.asset(
                  "assets/image/reels.png",
                  scale: 15,
                ),
                title: Text(
                  "Watch Reels",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
                subtitle:const Text("Watch creative videos"),
                trailing:const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Divider(),
              // create reels
              ListTile(
                leading: Image.asset(
                  "assets/image/rating.png",
                  scale: 12,
                ),
                title: Text(
                  "Create Reels",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
                subtitle:const Text("Create Reels and share your stories"),
                trailing:const Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

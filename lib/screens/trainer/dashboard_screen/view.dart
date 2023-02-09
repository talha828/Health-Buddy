import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/controller/trainer_details_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reels_screen/view.dart';
import '../trainer_login_screen/view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var trainer=Get.find<TrainerDetailsController>();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Dashboard",style: TextStyle(color: Colors.red),),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(trainer.name.value.toUpperCase(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              accountEmail: Text(trainer.email.value,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  trainer.name.value.substring(0,1).toUpperCase(),
                  style: const TextStyle(fontSize: 40.0,color: Colors.red),
                ),
              ),
            ),
            ListTile(
              leading:const Icon(Icons.home), title:const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:const Icon(Icons.post_add), title:const Text("Post"),
              onTap: () {
                //Get.to(const ChoseOptionScreen());
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading:const Icon(Icons.video_call), title:const Text("Reel"),
              onTap: () {
                Navigator.pop(context);
                Get.to(const ReelsScreen());
              },
            ),
            ListTile(
              leading:const Icon(Icons.contacts), title:const Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:const Icon(Icons.logout), title:const Text("Logout"),
              onTap: ()async {
                Navigator.pop(context);
                final prefs=await SharedPreferences.getInstance();
                prefs.setString("email","null");
                prefs.setString("password", "null");
                Get.to(()=>const TrainerLoginScreen());
              },
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}

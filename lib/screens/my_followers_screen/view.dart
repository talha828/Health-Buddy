import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/set_current_location_screen/view.dart';

import '../followers_list_scren/view.dart';

class MyFollowersScreen extends StatefulWidget {
  const MyFollowersScreen({Key? key}) : super(key: key);

  @override
  State<MyFollowersScreen> createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  final Key _mapKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed: ()=>Navigator.pop(context),),
        title:const Text("Category",style: TextStyle(color: Colors.red),),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: width *0.02,vertical: width *0.02),
          child: ListView(
            children: list.map((e) => ListTile(
              onTap: ()async{

                Get.to(MyFollowersListScreen(key:_mapKey));
                },
              shape: Border(
                bottom: BorderSide(color:const Color(0xff797979).withOpacity(0.5) ,width: 2),
              ),
              title: Text(e),
              trailing:const Icon(Icons.arrow_forward_ios_outlined),
            )).toList(),
          )
      ),
    ));
  }
  List<String>list=["Gym Buddy","Walking Dogs","Dessert","Lamb"];
}

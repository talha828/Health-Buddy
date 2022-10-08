import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/set_location_screen/view.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed: ()=>Navigator.pop(context),),
        title:const Text("Create Post",style: TextStyle(color: Colors.red),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width *0.02,vertical: width *0.02),
        child: ListView(
          children: list.map((e) => ListTile(
            onTap: ()=>Get.to(const SetLocationScreen()),
            shape: Border(
              bottom: BorderSide(color: Color(0xff797979).withOpacity(0.5) ,width: 2),
            ),
            title: Text(e),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )).toList(),
        )
      ),
    ));
  }
  List<String>list=["Gym Buddy","Walking Dogs","Dessert","Lamb"];
}

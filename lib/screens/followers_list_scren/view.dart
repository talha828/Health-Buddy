import 'package:flutter/material.dart';

class MyFollowersListScreen extends StatefulWidget {
  const MyFollowersListScreen({Key? key}) : super(key: key);

  @override
  State<MyFollowersListScreen> createState() => _MyFollowersListScreenState();
}

class _MyFollowersListScreenState extends State<MyFollowersListScreen> {
  int i=0;
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
          "Followers",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: width * 0.02),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (dismissDirection){
                  list.removeAt(index);
                  setState(() {});
                },
                child: ListTile(
                  onTap: (){
                    setState(() {
                      i=1;
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: width * 0.05,
                    child: Text(list[index].substring(0,1),style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  title: Text(list[index]),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.01),
                    color:i==0?Colors.red:Colors.grey,),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: width * 0.02,),
                    child:const Text("Pick Me",style: TextStyle(color: Colors.white),),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
              );
            },
            itemCount: list.length),
      ),
    ));
  }
  List<String>list=["Hamza Ahmed","Usama Ahmad"];
}

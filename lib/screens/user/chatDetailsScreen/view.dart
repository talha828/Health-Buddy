
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> with SingleTickerProviderStateMixin{
  late TabController _tabBarController;
  @override
  void initState() {
    _tabBarController =TabController(length: 2, vsync:this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: width * 0.1,),
            CircleAvatar(
              radius: width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width),
                child: Image.asset(
                  "assets/image/talha.jpg",
                  fit: BoxFit.cover,
                  width: width * 0.4,
                  height: width * 0.4,
                ),
              ),
            ),
            SizedBox(height: width * 0.1,),
            Text(
              "Talha Iqbal",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: width * 0.05,),
            Text(
              "talhaiqbal246gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.04,color: Colors.grey, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: width * 0.1,),
            TabBar(
              controller: _tabBarController,
                tabs:const [
              Tab(
                icon: Icon(Icons.camera_alt_outlined,color: Colors.red,),
              ),
                  Tab(
                    icon: Icon(Icons.file_present,color: Colors.red,),
                  )
            ],),
            Expanded(
              child: TabBarView(
                controller: _tabBarController,
                  children: [
                    Container(
                      child: GridView.count(
                        crossAxisSpacing: width * 0.02,
                          mainAxisSpacing: width * 0.02,
                          crossAxisCount: 3,
                        children: list.map((e) => Image.asset(e,fit: BoxFit.cover,)).toList(),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context,index){
                        return ListTile(
                          leading: Icon(Icons.file_present,color: Colors.black,),
                          title: Text("Don`t believe every thing you think",overflow: TextOverflow.ellipsis,maxLines: 1,),
                          subtitle: Text("pdf"),
                          trailing: CircleAvatar(
                            radius: width * 0.04,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.download,color: Colors.white,size: width * 0.05,)),
                        );
                      }),
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    ));
  }
  List<String>list=[
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
    "assets/image/talha.jpg",
  ];
}

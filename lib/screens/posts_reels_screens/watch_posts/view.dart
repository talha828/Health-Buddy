import 'package:flutter/material.dart';

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
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed: ()=>Navigator.pop(context),),
        title:const Text("Post",style: TextStyle(color: Colors.red),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.02),
        child:Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 7
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child:Text("T",style:TextStyle(color:Colors.white,fontSize: 16),
                    ),
                    ),
                    title: Text("Talha Iqbal",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    subtitle: Text("Karachi"),
                    trailing: Icon(Icons.more_horiz),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child:  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised",style: TextStyle(fontSize: width * 0.035),),
                  ),
                  SizedBox(height: 16,),
                  Image.asset("assets/image/talha.jpg",height: width,fit: BoxFit.fill,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/image/like.png",width: 25,height: 25,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/image/comment.png",width: 25,height: 25,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/image/cloud-computing.png",width: 25,height: 25,),
                      ),

                    ],
                  )
                ],
              ),
            )
          ],
        ) ,
      ),
    );
  }
}

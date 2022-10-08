import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/coaches_card_model.dart';
import 'package:health_buddy/screens/coaches_details_screen/view.dart';
import 'package:map_launcher/map_launcher.dart';

class GymBuddiesScreen extends StatefulWidget {
  const GymBuddiesScreen({Key? key}) : super(key: key);

  @override
  State<GymBuddiesScreen> createState() => _GymBuddiesScreenState();
}

class _GymBuddiesScreenState extends State<GymBuddiesScreen> {
  List<CoachesCardModel> card = [
    CoachesCardModel(title: "Talha Iqbal", desc: "Karachi  . Lahore  10 mints later ", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 1),
    CoachesCardModel(title: "Talha Iqbal", desc: "park  .           5hr left", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 2),
    CoachesCardModel(title: "Talha Iqbal", desc: "Karachi  . Lahore", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 3),
    CoachesCardModel(title: "Talha Iqbal", desc: "Karachi  . Lahore", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 4),
    CoachesCardModel(title: "Talha Iqbal", desc: "Karachi  . Lahore", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 5),
    CoachesCardModel(title: "Talha Iqbal", desc: "Karachi  . Lahore", town: "Karachi, Pakistan", image: "assets/image/talha.jpg", heroTag: 6),
  ];
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: ()=>Navigator.pop(context),icon:const Icon(Icons.arrow_back_ios),),
            title:const Center(child:Text("Gym Buddy",style: TextStyle(color: Colors.red),)),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.add))
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: width * 0.04),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder:(context,index){
              return Container(
                height: width  ,
                decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow:const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 3),
                          blurRadius: 7),
                    ],
                    borderRadius:
                    BorderRadius.circular(width * 0.02)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Hero(
                          tag: card[index].heroTag.toString(),
                          child: Container(
                              //padding: EdgeInsets.symmetric(vertical: width * 0.09,horizontal: width * 0.09),
                              child: Image.asset(
                                card[index].image.toString(),
                                fit: BoxFit.cover,
                                width: width * 0.5,
                                height: width * 0.5,
                              )),
                        )),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: width *0.05,vertical: width * 0.03),
                      child: ListTile(
                        leading: InkWell(
                          onTap: ()async{
                            final availableMaps = await MapLauncher.installedMaps;
                              await MapLauncher.showMarker(
                                mapType: MapType.google,
                                coords: Coords(24.830080, 67.080081),
                                title: "Talha Iqbal",
                                description: "Flutter Developer",
                              );
                          },
                          child: CircleAvatar(
                            radius: width * 0.07,
                            child: CircleAvatar(
                              radius: width * 0.05,
                              backgroundColor: Colors.red,
                              child: Image.asset("assets/image/direction.png",scale: 22,color: Colors.white,),),
                          ),
                        ),
                        title: Text(card[index].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                        subtitle: Text(card[index].desc.toString()),
                        trailing: CircleAvatar(
                          radius: width * 0.07,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: width * 0.05,
                            child:Transform.rotate(
                                angle: 140/360,
                                child: Icon(Icons.send,color: Colors.white,size: width * 0.05,)) ,
                          ),
                        ),
                      ),
                    )
                    // Container(
                    //     padding: EdgeInsets.symmetric(horizontal: width *0.05,vertical: width * 0.03),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.only(
                    //             bottomLeft:
                    //             Radius.circular(width * 0.02),
                    //             bottomRight:
                    //             Radius.circular(width * 0.02))),
                    //     height: width * 0.32,
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //
                    //       children: [
                    //         Text(card[index].title.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: width * 0.05,fontWeight: FontWeight.bold),),
                    //         Text(card[index].desc.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: width * 0.03),),
                    //         Text(card[index].town.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: width * 0.03),),
                    //       ],
                    //     ))
                  ],
                ),
              );
            },itemCount: 5,separatorBuilder: (context,index){
              return SizedBox(height: width * 0.04,);
            },),
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:scaled_list/scaled_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:width * 0.02),
              child: Icon(Icons.notifications_none_outlined,),
            )
          ],
          title: Center(
            child: Text("Dashboard",style: TextStyle(
              color: Colors.red
            ),),
          ),
        ),
        drawer: Drawer(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06,vertical: width * 0.06),
                    child: Text("Category",style: TextStyle(fontSize:width * 0.06 ,fontWeight:FontWeight.bold,),),
                  ),
                  Container(
                    //color: Colors.grey,
                    child: ScaledList(
                      showDots: false,
                    itemCount: categories.length,
                    itemColor: (index) {
                      return kMixedColors[index % kMixedColors.length];
                    },
                    itemBuilder: (index, selectedIndex) {
                      final category = categories[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: selectedIndex == index ? 100 : 50,
                              child: Image.asset(category.image,color: Colors.white,width: width * 0.2,),
                            ),
                            Text(
                              category.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: selectedIndex == index ?FontWeight.bold:FontWeight.normal,
                                  fontSize: selectedIndex == index ? 20 : 15),
                            )
                          ],
                        ),
                      );
                    },
                ),
                  ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06,vertical: width * 0.02),
                      child: Text("Coaches",style: TextStyle(fontSize:width * 0.06 ,fontWeight:FontWeight.bold,),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                      child: AnimatedList(
                        shrinkWrap: true,
                        initialItemCount: 3,
                        itemBuilder: (context, index, animation) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text("DOG TAINING",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                trailing: Icon(Icons.arrow_forward_ios_outlined),
                              ),
                              Divider()
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            isLoading?const Positioned.fill(child: LoadingIndicator()):Container()
          ],
        ),
      ),
    );
  }
    final List<Color> kMixedColors = [
      Colors.red,
      Colors.red,
      Colors.red,
      Colors.red,
    ];

    final List<Category> categories = [
      Category(image: "assets/image/gym_friends.png", name: "Buddy Gym"),
      Category(image: "assets/image/walking_dog.png", name: "Walking Dog"),
      Category(image: "assets/image/walking.png", name: "Dessert"),
      Category(image: "assets/image/diet.png", name: "Lamb"),

    ];
}
class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/user_model.dart';
import 'package:health_buddy/screens/caoches_menu_screen/view.dart';
import 'package:health_buddy/screens/create_post_screen/view.dart';
import 'package:health_buddy/screens/gym_buddies_screen/view.dart';
import 'package:health_buddy/screens/i_am_trainer_screen/view.dart';
import 'package:health_buddy/screens/login_screen/view.dart';
import 'package:health_buddy/screens/my_followers_screen/view.dart';
import 'package:health_buddy/screens/view_posts_screen/view.dart';
import 'package:health_buddy/widgets/health_loading_indicator.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  final userDetails=Get.find<UserDetails>();
  List<String> coaches = ["Dog Training", "Dieting Training", "Counselling"];

  @override
  Widget build(BuildContext context) {
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
              ),
            )
          ],
          title: const Center(
            child: Text(
              "Dashboard",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
               UserAccountsDrawerHeader(
                accountName: Text(userDetails.name.value,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                accountEmail: Text(userDetails.email.value,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    userDetails.name.value.substring(0,1),
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
                leading:const Icon(Icons.post_add), title:const Text("Create Post"),
                onTap: () {
                  Get.to(const CreatePostScreen());
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading:const Icon(Icons.follow_the_signs), title:const Text("My Followers"),
                onTap: () {
                  Get.to(const MyFollowersScreen());
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading:const Icon(Icons.follow_the_signs), title:const Text("I am Trainer"),
                onTap: () {
                 Get.to(const IamTrainerScreen());
                  //Navigator.pop(context);
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
                  Get.to(()=>const LoginScreen());
                },
              ),
            ],
          ),
        ),
      body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: width * 0.06),
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ScaledList(
                    showDots: false,
                    itemCount: categories.length,
                    itemColor: (index) {
                      return kMixedColors[index % kMixedColors.length];
                    },
                    itemBuilder: (index, selectedIndex) {
                      final category = categories[index];
                      return InkWell(
                        onTap: ()=>Get.to(const ViewPostsScreen()),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: selectedIndex == index ? 100 : 50,
                                child: Image.asset(
                                  category.image,
                                  color: Colors.white,
                                  width: width * 0.3,
                                ),
                              ),
                              Text(
                                category.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: selectedIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: selectedIndex == index ? 20 : 15),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: width * 0.02),
                    child: Text(
                      "Coaches",
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                              onTap:()=>Get.to(const CoachesMenu()),
                              title: Text(
                                coaches[index],
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            isLoading
                ? const Positioned.fill(child: LoadingIndicator())
                : Container()
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
    Category(image: "assets/image/gym_friends.png", name: "Gym Buddy "),
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

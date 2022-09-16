import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/login_screen/view.dart';
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
                accountName: Text("Talha Iqbal",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                accountEmail: Text("talhaiqbal246@gmail.com",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "T",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home), title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings), title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts), title: Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout), title: Text("Logout"),
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
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: selectedIndex == index ? 100 : 50,
                              child: Image.asset(
                                category.image,
                                color: Colors.white,
                                width: width * 0.2,
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

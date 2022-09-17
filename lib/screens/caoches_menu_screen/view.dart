import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_buddy/model/coaches_card_model.dart';
import 'package:health_buddy/screens/coaches_details_screen/view.dart';

class CoachesMenu extends StatefulWidget {
  const CoachesMenu({Key? key}) : super(key: key);

  @override
  State<CoachesMenu> createState() => _CoachesMenuState();
}

class _CoachesMenuState extends State<CoachesMenu> {
  List<CoachesCardModel> card = [];
  @override
  void initState() {
    card.add(CoachesCardModel(
        title: "Talha Iqbal",
        desc:
            "Health Fitness trainer with 75+ year of experience and hard work",
        town: "Karachi, Pakistan",
        image: "assets/image/login.svg",
        heroTag: 1));
    card.add(CoachesCardModel(
        title: "Talha Iqbal",
        desc:
            "Health Fitness trainer with 75+ year of experience and hard work",
        town: "Karachi, Pakistan",
        image: "assets/image/signUp.svg",
        heroTag: 2));
    card.add(CoachesCardModel(
        title: "Talha Iqbal",
        desc:
            "Health Fitness trainer with 75+ year of experience and hard work",
        town: "Karachi, Pakistan",
        image: "assets/image/signUp.svg",
        heroTag: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.red,
            ),
          ),
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
              "Coaches Menu",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.5)),
              height: height * 0.7,
              width: width,
              child: AppinioSwiper(
                  onTapDisabled:()=>Get.to(()=>CoachesDetailsScreen()),
                  unlimitedUnswipe: true,
                  onSwipe: (index, detectedDirection) {
                    if(detectedDirection==AppinioSwiperDirection.right){
                      Get.to(()=>CoachesDetailsScreen());
                    }
                  },
                  key: UniqueKey(),
                  cards: card
                      .map((e) => Container(
                            height: width * 0.5,
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
                                      tag: e.heroTag.toString(),
                                      child: InkWell(
                                        onTap: ()=>Get.to(()=>CoachesDetailsScreen()),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: width * 0.09,horizontal: width * 0.09),
                                            child: SvgPicture.asset(
                                  e.image.toString(),
                                  width: width * 0.5,
                                  height: width * 0.5,
                                )),
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: width *0.05,vertical: width * 0.03),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(width * 0.02),
                                            bottomRight:
                                                Radius.circular(width * 0.02))),
                                    height: width * 0.32,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: [
                                        Text(e.title.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: width * 0.05,fontWeight: FontWeight.bold),),
                                        Text(e.desc.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontSize: width * 0.03),),
                                        Text(e.town.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: width * 0.03),),
                                      ],
                                    ))
                              ],
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}

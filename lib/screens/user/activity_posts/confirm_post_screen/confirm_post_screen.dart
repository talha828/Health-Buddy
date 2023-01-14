import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/firebase/database.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:health_buddy/screens/user/main_screen/view.dart';
import 'package:health_buddy/widgets/healty_create_post_card.dart';

class ConfirmPostScreen extends StatefulWidget {
  const ConfirmPostScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPostScreen> createState() => _ConfirmPostScreenState();
}

class _ConfirmPostScreenState extends State<ConfirmPostScreen> {
  final createPostDetails = Get.find<PostController>();
  bool isLoading=false;
  void setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Confirm your post",
            style: TextStyle(color: Colors.red),
          ),
        ),
        body: Stack(

          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.04, horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //create post card
                  CreatePostCard(
                    width: width,
                    createPostDetails: createPostDetails,
                    onTap: () {
                      setLoading(true);
                      Database.createPost(createPostDetails)
                          .then((value) =>
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Congratulation',
                        desc: 'Your post successfully created',
                        btnOkColor: Colors.red,
                        btnOkOnPress: () {
                          setLoading(false);
                          Get.to(const MainScreen());
                        },
                      )
                        ..show())
                          .catchError((e) {
                        setLoading(false);
                        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
                      });

                    }
                  )
                ],
              ),
            ),
            isLoading?Positioned.fill(child:Container(color: Colors.black54,child:Center(child: const CircularProgressIndicator()),)):Container()
          ],
        ),
      ),
    );
  }
}



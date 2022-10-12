import 'package:flutter/material.dart';

class ConfirmPostScreen extends StatefulWidget {
  const ConfirmPostScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPostScreen> createState() => _ConfirmPostScreenState();
}

class _ConfirmPostScreenState extends State<ConfirmPostScreen> {
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
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(width *0.02),
                      border: Border.all(color: Colors.red,width: 2)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Talha Iqbal",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child: Text("Gym Buddy",style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        const Divider(color: Colors.red,),
                        Row(
                          children: [
                            Text("From",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Text("Street 07, Sector A, Rhaman Colony Karachi, pakistan"),
                        SizedBox(height: width * 0.02),
                        Row(
                          children: [
                            Text("To",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Text("Shaheen Part,Near Hospital,Sector A, Rhaman Colony Karachi, pakistan"),
                        const Divider(color: Colors.red,),
                        Row(
                          children: [
                            Text("Timings",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                          ],
                        ),
                        SizedBox(height: width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child: Text("11:30",style: TextStyle(color: Colors.white),),
                            ),
                            Text("To",textAlign: TextAlign.start,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: width * 0.05),),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(width  * 0.02),
                              ),
                              child: Text("12:00",style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.red,),
                        SizedBox(height: width * 0.02),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          padding: EdgeInsets.symmetric(vertical: width  * 0.02,horizontal: width *0.04),
                            child:Text("Post Now",style: TextStyle(color: Colors.white),)),
                        SizedBox(height: width * 0.02),

                      ],
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

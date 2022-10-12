import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/confirm_post_screen/confirm_post_screen.dart';

class PostFinalDetailsScreen extends StatefulWidget {
  const PostFinalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PostFinalDetailsScreen> createState() => _PostFinalDetailsScreenState();
}

class _PostFinalDetailsScreenState extends State<PostFinalDetailsScreen> {
  TimeOfDay _time = TimeOfDay.now();
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }
  TimeOfDay _time2 = TimeOfDay.now();

  void onTimeChanged2(TimeOfDay newTime) {
    setState(() {
      _time2 = newTime;
    });
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text(
              "Set Time Duration",
              style: TextStyle(color: Colors.red),
            ),
          ),
          bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
              child: ElevatedButton(onPressed: (){
                Get.to(const ConfirmPostScreen());
              },child: Text("Move Next"),)),
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_time.hour.toString()+" : "+_time.minute.toString(),textAlign: TextAlign.center,style: TextStyle(
                fontSize: width * 0.2
              ),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time,
                        is24HrFormat: true,
                        onChange: onTimeChanged,
                        minuteInterval: MinuteInterval.FIVE,
                        // Optional onChange to receive value as DateTime
                        onChangeDateTime: (DateTime dateTime) {
                          print(_time.hour.toString() + ":"+_time.minute.toString());
                          debugPrint("[debug datetime]:  $dateTime");
                          print("[debug datetime]:  $dateTime");
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Select Start Timing",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: width * 0.2,),
              Text(_time2.hour.toString()+" : "+_time2.minute.toString(),textAlign: TextAlign.center,style: TextStyle(
                  fontSize: width * 0.2
              ),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time2,
                        is24HrFormat: true,
                        onChange: onTimeChanged2,
                        minuteInterval: MinuteInterval.FIVE,
                        // Optional onChange to receive value as DateTime
                        onChangeDateTime: (DateTime dateTime) {
                          print(_time2.hour.toString() + ":"+_time2.minute.toString());
                          debugPrint("[debug datetime]:  $dateTime");
                          print("[debug datetime]:  $dateTime");
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Select Start Timing",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ) ,
        )
    );
  }
}

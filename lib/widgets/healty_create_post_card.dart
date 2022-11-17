import 'package:flutter/material.dart';
import 'package:health_buddy/model/create_post_model.dart';
import 'package:intl/intl.dart';
var f=DateFormat('dd-MM-yyyy hh:mm');
class CreatePostCard extends StatelessWidget {
   CreatePostCard({
    Key? key,
    required this.width,
    required this.onTap,
    required this.createPostDetails,
  }) : super(key: key);

  final double width;
  final CreatePost createPostDetails;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(width * 0.02),
          border: Border.all(color: Colors.red, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                createPostDetails.name.value,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Text(
                  createPostDetails.type.value,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.red,
          ),
          Row(
            children: [
              Text(
                "From",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Text(createPostDetails.fromAddress.value),
          SizedBox(height: width * 0.02),
          Row(
            children: [
              Text(
                "To",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Text(createPostDetails.toAddress.value),
          const Divider(
            color: Colors.red,
          ),
          Row(
            children: [
              Text(
                "Timings",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Text(
                  convertTime(createPostDetails.fromTime.value)
                  //"${createPostDetails.fromTime.value.hour.toString()} : ${createPostDetails.fromTime.value.minute.toString()}",
                  ,style: const TextStyle(color: Colors.white),
                ),
              ),
              Text(
                " : ",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Text(
                  convertTime(createPostDetails.toTime.value)
                  //"${createPostDetails.toTime.value.hour.toString()} : ${createPostDetails.toTime.value.minute.toString()}",
                  ,style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.red,
          ),
          SizedBox(height: width * 0.02),
          InkWell(
            onTap: onTap,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                child: const Text(
                  "Post Now",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(height: width * 0.02),
        ],
      ),
    );
  }
  String convertTime(int timestamp)=> f.format(DateTime.fromMillisecondsSinceEpoch(timestamp)).substring(0,16);
}


import 'package:flutter/material.dart';
import 'package:health_buddy/model/create_post_model.dart';

class FollowMeCard extends StatelessWidget {
  const FollowMeCard({
    Key? key,
    required this.width,
    required this.showRoute,
    required this.createPostDetails,
    required this.follow,
  }) : super(key: key);

  final double width;
  final CreatePostModel createPostDetails;
  final Function()? showRoute;
  final Function()? follow;

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
                createPostDetails.name,
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
                  createPostDetails.type,
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
          Text(createPostDetails.fromAddress),
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
          Text(createPostDetails.toAddress),
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
                  "${createPostDetails.fromTime}",
                  style: const TextStyle(color: Colors.white),
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
                  "${createPostDetails.toTime}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.red,
          ),
          SizedBox(height: width * 0.02),
          InkWell(
            onTap: showRoute,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                child: const Text(
                  "Show Route",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(height: width * 0.02),
          InkWell(
            onTap: showRoute,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                child: const Text(
                  "Follow Route",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(height: width * 0.02),
        ],
      ),
    );
  }
}
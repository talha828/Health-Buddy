import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:get/get.dart';

class CreatePost extends GetxController{
  RxString name ="".obs;
  RxString type="".obs;
  RxString fromAddress="".obs;
  RxString toAddress="".obs;
  RxInt fromTime= DateTime.now().millisecondsSinceEpoch.obs;
  RxInt toTime=DateTime.now().millisecondsSinceEpoch.obs;
  Rx<LatLong> fromLatLong=LatLong(latitude: 000000, longitude: 0000).obs;
  Rx<LatLong> toLatLong=LatLong(latitude: 000000, longitude: 0000).obs;
  RxDouble timestamp=0.00.obs;
}

class CreatePostModel {
  String name;
  String type;
  String fromAddress;
  String toAddress;
  String fromTime ;
  String toTime;
  GeoPoint fromLatLong;
  GeoPoint toLatLong;
  int timestamp;

  CreatePostModel({required this.name,required this.type,required this.fromAddress,required this.toAddress,required this.fromTime,required this.fromLatLong,required this.toLatLong,required this.timestamp,required this.toTime});
}
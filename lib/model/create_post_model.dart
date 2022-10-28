import 'package:flutter/material.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:get/get.dart';

class CreatePost extends GetxController{
  RxString name ="".obs;
  RxString type="".obs;
  RxString fromAddress="".obs;
  RxString toAddress="".obs;
  Rx<TimeOfDay> fromTime= TimeOfDay.now().obs;
  Rx<TimeOfDay> toTime=TimeOfDay.now().obs;
  Rx<LatLong> fromLatLong=LatLong(latitude: 000000, longitude: 0000).obs;
  Rx<LatLong> toLatLong=LatLong(latitude: 000000, longitude: 0000).obs;
  RxDouble timestamp=0.00.obs;
}
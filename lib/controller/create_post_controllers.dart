import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController{
  RxString name="".obs;
  RxString category="".obs;
  RxString fromAddress="".obs;
  RxString toAddress="".obs;
  Rx<GeoPoint> startPoint=(null as GeoPoint).obs;
  Rx<GeoPoint> endPoint=(null as GeoPoint).obs;
  RxString startTime="".obs;
  RxString endTime="".obs;
  RxString date="".obs;
  RxString timestamp="".obs;
}
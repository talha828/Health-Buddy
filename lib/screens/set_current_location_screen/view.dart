import 'package:flutter/material.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:flutter_google_location_picker/flutter_google_location_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:health_buddy/screens/set_final_location_screen/view.dart';
import 'package:health_buddy/screens/temp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SetCurrentLocationScreen extends StatefulWidget {
  const SetCurrentLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SetCurrentLocationScreen> createState() =>
      _SetCurrentLocationScreenState();
}

class _SetCurrentLocationScreenState extends State<SetCurrentLocationScreen> {
  Future<LatLong> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition();
    return LatLong(latitude: position.latitude, longitude: position.longitude);
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
            "Set current Location",
            style: TextStyle(color: Colors.red),
          ),
        ),
        body: FutureBuilder<LatLong>(
          future: _determinePosition(),
          builder: (context, AsyncSnapshot<LatLong> snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(child: CircularProgressIndicator());
            }

            return FlutterGoogleLocationPicker(
              center: LatLong(
                  latitude: snapshot.data!.latitude,
                  longitude: snapshot.data!.longitude),
              onPicked: (value) {
                print(value.displayName);
                Get.to(const SetFinalLocationScreen());
              },
              buttonWidget: Container(
                color: Colors.red,
                margin: EdgeInsets.symmetric(vertical: width * 0.04),
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.04),
                child: const Text(
                  "Set Current Location",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

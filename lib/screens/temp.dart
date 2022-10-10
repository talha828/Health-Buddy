import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:flutter_google_location_picker/flutter_google_location_picker.dart';

class Temp extends StatefulWidget  {
  const Temp({Key? key,required this.lat,required this.long}) : super(key: key);
  final double lat;
  final double long;

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlutterGoogleLocationPicker(
          center:LatLong(latitude: widget.lat,longitude:widget.long),
          onPicked:(value){
            print(value.address);
          },
        ),
      ),
    );
  }
}

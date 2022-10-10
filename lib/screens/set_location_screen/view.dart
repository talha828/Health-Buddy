import 'package:flutter/material.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:flutter_google_location_picker/flutter_google_location_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_buddy/screens/temp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';





class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key}) : super(key: key);

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {

  Future<Position> _determinePosition() async {
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
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading:IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed: ()=>Navigator.pop(context),),
        centerTitle: true,
        title:const Text("Mark Location",style: TextStyle(color: Colors.red),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: width *0.02,horizontal: width *0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: width * 0.03,),
              Text("From Location",style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: width * 0.03,),
                //padding: EdgeInsets.symmetric(horizontal: width * 0.02,),
              Container(
                width: width * 0.8,
                height: width,
                child: FlutterGoogleLocationPicker(
                  center:LatLong(latitude: 55.3781,longitude:3.4360),
                  onPicked:(value){
                    print(value.address);
                  },
                ),
              ),
              SizedBox(height: width * 0.03,),
              Text("To Location",style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: width * 0.03,),
              //padding: EdgeInsets.symmetric(horizontal: width * 0.02,),
              Container(
                width: width * 0.8,
                height: width,
                child: FlutterGoogleLocationPicker(
                  center:LatLong(latitude: 55.3781,longitude:3.4360),
                  onPicked:(value){
                    print(value.address);
                  },
                ),
              ),
              SizedBox(height: width * 0.09,),
              ElevatedButton(
                  // autofocus: true,
                  onPressed: ()async{
                    Alert(context: context, title: "Congratulation", desc: "Post Successfully posted").show();

                    //Position position =await _determinePosition();
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Temp(lat: 55.3781, long: 3.4360)));
                  }, child: Text("Post Now"))
            ],
          ),
        ),
      ),
    ));
  }
}

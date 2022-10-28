import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_location_picker/export.dart';
import 'package:flutter_google_location_picker/flutter_google_location_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:health_buddy/widgets/health_button.dart';
import 'package:health_buddy/widgets/health_text_field.dart';
import 'package:image_picker/image_picker.dart';

class IamTrainerScreen extends StatefulWidget {
  const IamTrainerScreen({Key? key}) : super(key: key);

  @override
  State<IamTrainerScreen> createState() => _IamTrainerScreenState();
}

class _IamTrainerScreenState extends State<IamTrainerScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool flag = false;
  late File image;
   String address="";
  String dropdownvalue = 'Dog Trainer';
  var items = ["Dog Trainer","Dieting Trainer","Counselling"];
  final _formKey = GlobalKey<FormState>();
  Future getImage() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    image = File(xFile!.path);
    flag = true;
    setState(() {});
  }
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
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Trainer",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                flag
                    ? CircleAvatar(
                        radius: width * 0.2,
                        child: ClipOval(
                          child: Image.memory(
                            image.readAsBytesSync(),
                            fit: BoxFit.cover,
                            width: width * 0.8,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () => getImage(),
                        child: CircleAvatar(
                          radius: width * 0.2,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person_add_alt,
                            size: width * 0.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                HealthTextField(
                  email: name,
                  width: width,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  hintText: "Full Name",
                ),
                HealthTextField(
                  email: details,
                  width: width,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Details';
                    }
                    return null;
                  },
                  hintText: "About your self",
                ),
                DropdownButton(
                  isExpanded:true,
                  autofocus: true,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                Container(
                  height: width * 0.6,
                  child: FutureBuilder<LatLong>(
                      future: _determinePosition(),
                      builder: (context, AsyncSnapshot<LatLong> snapshot) {
                        if (ConnectionState.waiting ==
                            snapshot.connectionState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return FlutterGoogleLocationPicker(
                          center: LatLong(
                              latitude: snapshot.data!.latitude,
                              longitude: snapshot.data!.longitude),
                          onPicked: (value) {
                           address=value.latLong.longitude.toString();
                          },
                          buttonWidget: Container(
                            color: Colors.red,
                            margin:
                                EdgeInsets.symmetric(vertical: width * 0.04),
                            padding: EdgeInsets.symmetric(
                                vertical: width * 0.02,
                                horizontal: width * 0.04),
                            child: const Text(
                              "My Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        );
                      }),
                ),
                HealthButton(width: width, login: "login", onTap: ()async{
                  if(flag){
                        if (_formKey.currentState!.validate()) {
                          if (address.isNotEmpty) {
                            AwesomeDialog(
                              btnOkColor: Colors.red ,
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Congratulation',
                              desc: 'you successfully register as a Trainer',
                              btnOkOnPress: () {},
                            ).show();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please Pick your address");
                          }
                        }
                      }else{
                    Fluttertoast.showToast(
                        msg: "Please Select Profile Picture");
                  }
                    },),
              ],
            ),
          ),
        ),
      ),
    ),);
  }
}

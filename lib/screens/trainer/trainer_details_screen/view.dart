import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_buddy/controller/trainer_details_controller.dart';
import 'package:health_buddy/firebase/database.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/health_button.dart';
import '../../../widgets/health_loading_indicator.dart';
import '../../../widgets/health_text_field.dart';

class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  final TextEditingController nickName=TextEditingController();
  final TextEditingController bio=TextEditingController();
  final TextEditingController address=TextEditingController();
  final TextEditingController country=TextEditingController();
  final trainer=Get.find<TrainerDetailsController>();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Gym Training';
  var items = [
    "Gym Training","Dog Training", "Dieting Training", "Counselling"
  ];
  bool isLoading=false;
  bool flag=false;
  late File? file;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: ()async{
                            XFile? image=await _picker.pickImage(source: ImageSource.gallery);
                            if(image != null){
                              file=File(image.path);
                              flag=true;
                              setState(() {});
                            }else{{
                              Fluttertoast.showToast(msg: "Error: File not found");
                            }
    }
                          },
                          child:flag?CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: width * 0.2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(file!.readAsBytesSync(),fit: BoxFit.fill,)),
                          ) : CircleAvatar(
                            radius: width * 0.18,
                            child: Icon(Icons.person_add_alt,size: width * 0.2,color: Colors.red,),
                          ),
                        ),
                        HealthTextField(
                          email: nickName,
                          width: width,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                          hintText: "Nick Name",
                        ),
                        HealthTextField(
                          email: bio,
                          width: width,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Nick Bio';
                            }
                            return null;
                          },
                          hintText: "Bio",
                        ),
                        HealthTextField(
                          email: address,
                          width: width,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Address';
                            }
                            return null;
                          },
                          hintText: "Address",
                        ),
                        HealthTextField(
                          email: country,
                          width: width,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Country';
                            }
                            return null;
                          },
                          hintText: "Country",
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.grey)
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),

                        HealthButton(
                            width: width,
                            login: "Register",
                            onTap: ()async{
                              setLoading(true);
                              if(_formKey.currentState!.validate()){
                                if(file != null){
                                  trainer.nickName.value=nickName.text;
                                  trainer.bio.value=bio.text;
                                  trainer.address.value=address.text;
                                  trainer.country.value=country.text;
                                  trainer.trainerType.value=dropdownvalue;
                                  await Database.signUpTrainer(file!).then((value) => value?true:setLoading(false));
                                }else{
                                  Fluttertoast.showToast(msg: "Please upload your image");
                                  setLoading(false);
                                }
                              }
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isLoading
                ? const Positioned.fill(child: LoadingIndicator())
                : Container()
          ],
        ),
      ),
    );
  }
  setLoading(bool value)=> setState(() {isLoading=value;});
}

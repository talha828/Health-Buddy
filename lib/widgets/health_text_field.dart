import 'package:flutter/material.dart';

class HealthTextField extends StatelessWidget {
  HealthTextField(
      {Key? key,
        required this.email,
        required this.width,
        required this.validator,
        required this.obscureText,
        required this.hintText})
      : super(key: key);

  final TextEditingController email;
  final double width;
  final String hintText;
  final bool obscureText;
  String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: email,
      obscureText:obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade300,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)),
    );
  }
}

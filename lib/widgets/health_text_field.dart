
import 'package:flutter/material.dart';

class HealthTextField extends StatelessWidget {
  const HealthTextField({
    Key? key,
    required this.email,
    required this.login,
    required this.width,
  }) : super(key: key);

  final TextEditingController email;
  final String login;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: email,
      decoration: InputDecoration(
          hintText: login,
          filled: true,
          fillColor: Colors.grey.shade300,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)
      ),
    );
  }
}

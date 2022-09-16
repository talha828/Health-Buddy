import 'package:flutter/material.dart';

class HealthButton extends StatelessWidget {
    HealthButton({
    Key? key,
    required this.width,
    required this.login,
    required this.onTap
  }) : super(key: key);

  final double width;
  final String login;
        var    onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(width * 0.03)
        ),
        child: Text(login,style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: width * 0.04
        ),),
      ),
    );
  }
}

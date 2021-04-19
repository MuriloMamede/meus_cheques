import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustonRoundedButton extends StatelessWidget {
  const CustonRoundedButton({this.title, this.onPressed}) : super();

  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onPressed: onPressed,
      color: Get.theme.primaryColor,
    );
  }
}

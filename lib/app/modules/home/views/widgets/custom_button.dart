import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.radius,
      this.color = primaryColor})
      : super(key: key);
  final Function() onPressed;
  final String title;
  final double? radius;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size.fromWidth(Get.width),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 5)))),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/routes/app_routes.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: Get.height * 0.06,
        color: Colors.red,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
              }),
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
                Get.offNamed(
                  Routes.HOME,
                );
              }),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Get.reset();
              }),
        ]),
      ),
    );
  }
}

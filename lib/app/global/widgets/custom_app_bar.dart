import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final double size = Get.height;
  final String title;
  final double height;
  final List<Widget> leadings;
  final List<Widget> actions;

  CustomAppBar(
    this.title, {
    Key? key,
    this.leadings = const [],
    this.actions = const [],
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
    );
  }
}

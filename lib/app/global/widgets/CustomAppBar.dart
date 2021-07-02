import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomAppBar extends PreferredSize {
  final double size = Get.height;
  final String title;
  final double height;
  final List<Widget> leadings;
  final List<Widget> actions;

  CustomAppBar(
    this.title, {
    this.leadings = const [],
    this.actions = const [],
    this.height = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: Text(title),
      leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
    );
  }
}

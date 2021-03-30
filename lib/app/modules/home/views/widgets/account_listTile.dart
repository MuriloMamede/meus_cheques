import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountListTile extends StatelessWidget {
  final title;
  AccountListTile({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.07,
      color: Colors.amber,
      child: Align(alignment: Alignment.center, child: Text(title)),
    );
  }
}

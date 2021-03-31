import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_listTile.dart';

class AccountCreator extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.071;
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Get.theme.primaryColor,
              ),
            ),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                'Criar Conta:',
                style: TextStyle(color: Colors.white),
              ))),
      content: Container(
        height: itemHeight * 5,
        width: Get.width * 0.71,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: itemHeight - 0.01,
              width: Get.width * 0.69,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nome da Conta:',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                height: itemHeight - 0.01,
                width: Get.width * 0.69,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Numero da Conta:',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                height: itemHeight - 0.01,
                width: Get.width * 0.69,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Agência:',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                height: itemHeight - 0.01,
                width: Get.width * 0.69,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Banco:',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_listTile.dart';

class AccountCreator extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.07;
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child:
              Align(alignment: Alignment.center, child: Text('Suas Contas:'))),
      content: Container(
        height: itemHeight * _homeController.accountsList.length,
        width: Get.width * 0.7,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => AccountListTile(
            title: _homeController.accountsList[index].accountName,
          ),
          itemCount: _homeController.accountsList.length,
        ),
      ),
    );
  }
}

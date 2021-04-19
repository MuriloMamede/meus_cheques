import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_creator.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_listTile.dart';

class AccountList extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.071;
  @override
  Widget build(BuildContext context) {
    void openAccountCreator() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AccountCreator();
        },
      );
    }

    return CustomDialogWidget(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Get.theme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Suas Contas:',
                      style: TextStyle(color: Colors.white),
                    ))),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: InkResponse(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: openAccountCreator,
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ))),
            ),
          ],
        ),
      ),
      content: Container(
        height: _homeController.accountsList.length < 5
            ? itemHeight * _homeController.accountsList.length
            : itemHeight * 5,
        width: Get.width * 0.71,
        child: GetX<HomeController>(
          init: HomeController(),
          builder: (_) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var account = _homeController.accountsList[index];

                return AccountListTile(
                  name: account.accountName,
                  bankName: _homeController.getBankName(account.bankNumber),
                  accountNumber: account.accountNumber.toString(),
                );
              },
              itemCount: _homeController.accountsList.length,
            );
          },
        ),
      ),
    );
  }
}

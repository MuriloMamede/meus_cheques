import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountListTile extends StatelessWidget {
  final name;
  final bankName;
  final accountNumber;
  final bool showIcon;

  AccountListTile(
      {this.name, this.bankName, this.accountNumber, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
          top: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          showIcon == true
              ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  height: Get.height * 0.07,
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        CommunityMaterialIcons.bank,
                        color: Get.theme.primaryColor,
                      )),
                )
              : SizedBox(
                  width: 0,
                ),
          Container(
            height: Get.height * 0.07,
            child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: name + '\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      TextSpan(
                          text: bankName,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.black87)),
                      TextSpan(
                          text: '\n' + accountNumber,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.black87)),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

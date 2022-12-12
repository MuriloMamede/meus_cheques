import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountListTile extends StatelessWidget {
  final String name;
  final String bankName;
  final String accountNumber;
  final bool showIcon;

  const AccountListTile(
      {Key? key,
      required this.name,
      required this.bankName,
      required this.accountNumber,
      this.showIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
              : const SizedBox(
                  width: 0,
                ),
          SizedBox(
            height: Get.height * 0.07,
            child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: name + '\n',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      TextSpan(
                          text: bankName,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.black87)),
                      TextSpan(
                          text: '\n' + accountNumber,
                          style: const TextStyle(
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

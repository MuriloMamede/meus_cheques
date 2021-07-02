import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';

class ChequeListTile extends StatelessWidget {
  final Cheque _cheque;

  const ChequeListTile(this._cheque);

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
          Container(
            padding: const EdgeInsets.only(left: 10, right: 20),
            height: Get.height * 0.07,
            child: Align(
                alignment: Alignment.center,
                child: Icon(
                  CommunityMaterialIcons.bank,
                  color: Get.theme.primaryColor,
                )),
          ),
          Container(
            height: Get.height * 0.07,
            child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: _cheque.destinatario + '\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      TextSpan(
                          text: _cheque.date.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.black87)),
                      TextSpan(
                          text: '\n' + _cheque.number,
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

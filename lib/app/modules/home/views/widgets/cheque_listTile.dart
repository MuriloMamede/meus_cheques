import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';

class ChequeListTile extends StatelessWidget {
  final Cheque _cheque;

  const ChequeListTile(this._cheque);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,

          /* border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
            top: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
          ),*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              height: Get.height * 0.07,
              child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    CommunityMaterialIcons.bank,
                    color: Get.theme.primaryColor,
                  )),
            ),*/

            Container(
              padding: EdgeInsets.only(left: 15),
              height: Get.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: _cheque.destinatario,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                        TextSpan(
                            text: '\n' + _cheque.number,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black87)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    padding: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1.0, color: Colors.green.shade800),
                        bottom: BorderSide.none,
                        left: BorderSide.none,
                        right: BorderSide.none,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: _cheque.account.accountName,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black87)),
                              TextSpan(
                                  text: " " +
                                      _cheque.account.accountNumber.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      color: Colors.black87)),
                              TextSpan(
                                  text: " " + _cheque.number,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      color: Colors.black87)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateForm.format(_cheque.date),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'R\$ ' + numberForm.format(_cheque.value),
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

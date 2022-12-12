import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/theme/colors.dart';

class ChequeListTile extends StatelessWidget {
  final Cheque _cheque;
  final void Function()? onTap;
  final Color labelColor;
  const ChequeListTile(
    this._cheque, {
    Key? key,
    this.onTap,
    required this.labelColor,
  }) : super(key: key);

  Color getLabelColor() {
    Color color = primaryColor;
    switch (_cheque.status) {
      //TODO: transformar em enums
      case 'Emitido':
        color = Colors.amber.shade700;
        break;
      case 'Valor Depositado':
        color = Colors.blue;
        break;
      case 'Compensado':
        color = primaryColor;
        break;
      case 'Baixado':
        color = Colors.grey.shade700;
        break;
      case 'Sustado':
        color = Colors.red.shade400;
        break;
      default:
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      height: Get.height * 0.09,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: _cheque.destinatario,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87)),
                                TextSpan(
                                    text: '\n' + _cheque.number,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                        color: Colors.black87)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.only(top: 2),
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
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black87)),
                                      TextSpan(
                                          text: ' ' +
                                              _cheque.account.accountNumber
                                                  .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10,
                                              color: Colors.black87)),
                                      TextSpan(
                                          text: ' ' +
                                              _cheque.account.agency.toString(),
                                          style: const TextStyle(
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
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateFormwddMMyy.format(_cheque.date),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'R\$ ' + numberForm.format(_cheque.value),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
        /* Positioned(
            top: 3,
            left: 15,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: labelColor),
              child: Text(
                _cheque.account.accountName ?? " ",
                style: TextStyle(
                    color: labelColor.computeLuminance() > .5
                        ? Colors.black
                        : Colors.white),
              ),
            )),*/
        Positioned(
          top: 3,
          left: 15,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: getLabelColor()),
            child: Text(
              _cheque.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

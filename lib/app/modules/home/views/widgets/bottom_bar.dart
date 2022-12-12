import 'package:flutter/material.dart';
import 'package:meuscheques/app/global/functions.dart';
import 'package:meuscheques/app/theme/colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar(
      {Key? key, required this.qtdCheques, required this.totalCheques})
      : super(key: key);
  final int qtdCheques;
  final double totalCheques;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.only(
          left: 13,
          top: 8,
          bottom: 8,
        ),
        height: kBottomNavigationBarHeight * 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              qtdCheques.toString() + ' Cheques',
              textScaleFactor: 1,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  'R\$ ' + numberForm.format(totalCheques).toString(),
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

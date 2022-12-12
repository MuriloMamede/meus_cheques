import 'package:flutter/material.dart';
import 'package:meuscheques/app/theme/colors.dart';

class PopMenuSelector extends StatelessWidget {
  final Function(dynamic)? onSelected;
  final String textSelected;
  final Widget? widgetSelected;
  final double horizontalPadding;
  final double? height;
  final List<PopupMenuItem> itens;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  const PopMenuSelector({
    Key? key,
    required this.onSelected,
    required this.textSelected,
    required this.itens,
    this.borderColor = primaryColor,
    this.height,
    this.horizontalPadding = 5,
    this.iconColor = primaryColor,
    this.textColor = primaryColor,
    this.widgetSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration bordaVerde = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border(
        bottom: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
        top: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
        left: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
        right: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
      ),
      color: Colors.white,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
      child: PopupMenuButton<dynamic>(
          onSelected: onSelected,
          child: Container(
            height: height ?? 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: widgetSelected ??
                        Text(
                          textSelected,
                          style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: textColor),
                        )),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: iconColor,
                        size: 16,
                      )),
                ),
              ],
            ),
            decoration: bordaVerde,
          ),
          itemBuilder: (context) => itens),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class PopMenuSelector extends StatelessWidget {
  final Function(dynamic)? onSelected;
  final String textSelected;
  final Widget? widgetSelected;
  final double? horizontalPadding;
  final double selectedFontSize;
  final double? height;
  final List<PopupMenuItem>? itens;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isEnabled;

  final Color? iconColor;

  const PopMenuSelector({
    Key? key,
    required this.onSelected,
    required this.textSelected,
    required this.itens,
    this.selectedFontSize = 16.5,
    this.isEnabled = true,
    this.borderColor = darkPrimaryColor,
    this.height,
    this.backgroundColor,
    this.horizontalPadding = 5,
    this.iconColor = darkPrimaryColor,
    this.textColor = Colors.black,
    this.widgetSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration borda = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.black38));
    return Container(
      padding: const EdgeInsets.only(top: 3),
      child: PopupMenuButton<dynamic>(
          enabled: isEnabled,
          onSelected: isEnabled ? onSelected! : null,
          tooltip: isEnabled ? null : 'Desativado',
          child: Container(
            decoration: borda,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: constraints.maxWidth * .9,
                      padding: const EdgeInsets.only(left: 10),
                      child: widgetSelected ??
                          Text(isEnabled ? textSelected : '',
                              // overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: selectedFontSize,
                                color: textColor,
                              ))),
                  Container(
                    width: constraints.maxWidth * .1,
                    padding: const EdgeInsets.only(right: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: isEnabled ? iconColor : Colors.transparent,
                        )),
                  ),
                ],
              );
            }),
          ),
          itemBuilder: (context) => itens!),
    );
  }
}

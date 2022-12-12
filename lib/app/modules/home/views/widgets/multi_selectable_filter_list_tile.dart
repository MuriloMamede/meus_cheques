import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meuscheques/app/theme/colors.dart';

class MultiSelectableFilterListTile extends StatelessWidget {
  const MultiSelectableFilterListTile(
    this.labelWidget, {
    required this.onTap,
    required this.value,
    Key? key,
  }) : super(key: key);
  final Widget labelWidget;
  final Function() onTap;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: Get.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 0.5))),
          padding: const EdgeInsets.only(left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelWidget,
              Checkbox(
                  visualDensity: const VisualDensity(horizontal: -2),
                  checkColor: Colors.white,
                  activeColor: primaryColor,
                  value: value,
                  onChanged: (value) {
                    onTap();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

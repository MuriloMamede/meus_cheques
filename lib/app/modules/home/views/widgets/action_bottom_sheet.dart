import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet({
    required this.onEditTap,
    required this.onRemoveTap,
    Key? key,
  }) : super(key: key);

  final Function() onRemoveTap;
  final Function()? onEditTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.edit,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text('Editar'),
                ],
              ),
              onTap: onEditTap),
          ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            title: Row(
              children: const [
                Icon(
                  Icons.remove,
                ),
                SizedBox(
                  width: 16,
                ),
                Text('Remover'),
              ],
            ),
            onTap: () {
              Get.back();
              Get.defaultDialog(
                  content: Container(),
                  title: 'Deseja Mesmo Remover ?',
                  textConfirm: 'Sim',
                  textCancel: 'Não',
                  onConfirm: onRemoveTap,
                  onCancel: () => Get.back());
            },
          ),
        ],
      ),
    );
  }
}

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';

import 'account_list.dart';
import 'confirm_dialogs.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openAccountLister() async {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AccountList();
        },
      );
    }

    final controller = Get.find<HomeController>();
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            //TODO: add funcionalidades aos botões
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: openAccountLister,
                leading: const Icon(CommunityMaterialIcons.bank,
                    size: 20.0, color: Colors.white),
                title: const Text('Contas Bancárias'),
                textColor: Colors.white,
                dense: true,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(CommunityMaterialIcons.trash_can,
                    size: 20.0, color: Colors.white),
                title: const Text('Apagar Dados'),
                textColor: Colors.white,
                dense: true,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.info_outline_rounded,
                    size: 20.0, color: Colors.white),
                title: const Text('Sobre App'),
                textColor: Colors.white,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  dialogConfirmAviso(
                    textContent: 'Deseja mesmo sair?',
                    confirmTap: controller.signOut,
                  );
                },
                leading: const Icon(Icons.logout_rounded,
                    size: 20.0, color: Colors.white),
                title: const Text('Sair'),
                textColor: Colors.white,
                dense: true,
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text.rich(
                TextSpan(
                  text: 'Desenvolvido por ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Murilo Mamede',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

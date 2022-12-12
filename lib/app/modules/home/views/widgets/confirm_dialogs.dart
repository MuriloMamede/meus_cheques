import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as aw;

dialogConfirmAviso(
    {required String textContent,
    String title = 'Cuidado',
    String confirmTxt = 'Sim',
    String cancelTxt = 'Não',
    required Function() confirmTap}) {
  return aw.AwesomeDialog(
    context: Get.context!,
    dialogType: aw.DialogType.INFO,
    animType: aw.AnimType.SCALE,
    title: title,
    headerAnimationLoop: false,
    dismissOnBackKeyPress: true,
    dismissOnTouchOutside: true,
    desc: textContent,
    btnCancelOnPress: () {},
    btnCancelText: cancelTxt,
    btnOkText: confirmTxt,
    btnCancelColor: Colors.grey,
    btnOkColor: Colors.blue,
    btnOkOnPress: confirmTap,
  )..show();
}

dialogDeleteAviso(
    {required String textContent,
    String title = 'Cuidado',
    String confirmTxt = 'Sim',
    String cancelTxt = 'Não',
    required Function() confirmTap}) {
  return aw.AwesomeDialog(
    context: Get.context!,
    dialogType: aw.DialogType.WARNING,
    animType: aw.AnimType.SCALE,
    title: title,
    headerAnimationLoop: false,
    dismissOnBackKeyPress: true,
    dismissOnTouchOutside: true,
    desc: textContent,
    btnCancelOnPress: () {},
    btnCancelText: cancelTxt,
    btnOkText: confirmTxt,
    btnCancelColor: Colors.grey,
    btnOkColor: Colors.amber.shade600,
    btnOkOnPress: confirmTap,
  )..show();
}

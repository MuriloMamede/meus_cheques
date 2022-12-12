import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bank_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/global/strings.dart';
import 'package:meuscheques/app/global/widgets/snacksbar.dart';

import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/theme/colors.dart';

import 'dialog_textfield.dart';
import 'pop_up_menu_selector.dart';

class AccountCreator extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.071;
  final _formKey = GlobalKey<FormState>();

  AccountCreator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      minWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Get.theme.primaryColor,
          ),
          child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Criar Conta:',
                style: TextStyle(color: Colors.white),
              ))),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Nome da Conta:',
                controller: _homeController.accountNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return requiredField;
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: 'Numero da Conta:',
                keyboardType: TextInputType.number,
                controller: _homeController.accountNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return requiredField;
                  } else if (int.tryParse(value) == null) {
                    return 'Deve ser apenas números';
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: 'Agência:',
                keyboardType: TextInputType.number,
                controller: _homeController.accountAgencyController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return requiredField;
                  } else if (int.tryParse(value) == null) {
                    return 'Deve ser apenas números';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Banco:',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: darkPrimaryColor),
              ),
              Obx(
                () => PopMenuSelector(
                  itens: BANCOS.map((e) {
                    Bank bank = Bank.fromMap(e);

                    return PopupMenuItem(
                      child: Text(bank.name),
                      value: bank,
                    );
                  }).toList(),
                  onSelected: (value) {
                    _homeController.selectedBank(value);
                  },
                  textSelected: _homeController.selectedBank.value.name,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: Get.width * 0.67,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkResponse(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _homeController.clearControllers();
                  Get.back();
                },
                child: Container(
                  height: Get.height * 0.056,
                  padding: const EdgeInsets.all(8),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              InkResponse(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (_homeController.selectedBank.value.name !=
                        'Selecione') {
                      _homeController.saveAccount();
                      Get.back();
                    } else {
                      warningSnackBar('Atenção', 'Selecione o banco');
                    }
                  }
                },
                child: Container(
                  height: Get.height * 0.056,
                  padding: const EdgeInsets.all(8),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.theme.primaryColor //.withOpacity(0.5),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

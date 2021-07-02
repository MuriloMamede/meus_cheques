import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';

import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';

class ChequeCreator extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.071;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Get.theme.primaryColor,
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                'Novo Cheque',
                style: TextStyle(color: Colors.white),
              ))),
      content: Container(
        height: itemHeight * 4.2,
        width: Get.width * 0.71,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                label: 'Destinatário',
                controller: _homeController.accountNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatorio";
                  }
                  return null;
                },
              ),
              CustomTextField(
                //colocar receber valor formatado em real
                label: 'Valor',
                keyboardType: TextInputType.number,
                controller: _homeController.accountNumberController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatorio";
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: 'Número',
                keyboardType: TextInputType.number,
                controller: _homeController.accountAgencyController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatorio";
                  } else if (int.tryParse(value) == null) {
                    return "Deve ser apenas números";
                  }
                  return null;
                },
              ),
              /*Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Obx(() => PopupMenuButton<String>(
                    onSelected: (String s) {
                      _homeController.accountSelected(s);
                      _homeController
                          .titleConta(_homeController.getAccountName(s));
                    },
                    child: Container(
                      width: Get.width * 0.69,
                      height: Get.height * 0.056,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _homeController.titleConta.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.arrow_drop_down)),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          top: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          left: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    itemBuilder: (context) => _homeController.accountItens)),
              ),*/
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Obx(() {
                  return PopupMenuButton<BankAccount>(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context) => _homeController.accountItens,
                    onSelected: (BankAccount s) {
                      var accountSelected = s;
                      _homeController.accountSelected.value = accountSelected;
                      // _homeController.titleConta(accountSelected.accountName);
                    },
                    child: Container(
                      width: Get.width * 0.69,
                      height: Get.height * 0.056,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.center,
                                child: _homeController.accountSelected.value
                                            .accountName !=
                                        null
                                    ? RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: _homeController
                                                        .accountSelected
                                                        .value
                                                        .accountName +
                                                    '\n',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors.black87)),
                                            TextSpan(
                                                text: _homeController
                                                    .getBankName(_homeController
                                                        .accountSelected
                                                        .value
                                                        .bankNumber),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10,
                                                    color: Colors.black87)),
                                            TextSpan(
                                                text: '\n' +
                                                    _homeController
                                                        .accountSelected
                                                        .value
                                                        .accountNumber
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10,
                                                    color: Colors.black87)),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        _homeController.titleConta.value,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.arrow_drop_down)),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          top: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          left: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.black26,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          width: Get.width * 0.67,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkResponse(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _homeController.bankSelected('');
                  _homeController.clearControllers();
                  Get.back();
                },
                child: Container(
                  width: Get.width * 0.2,
                  height: Get.height * 0.04,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          fontSize: 17,
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
                  if (_formKey.currentState.validate()) {
                    _homeController.saveAccount();
                    Get.back();
                  }
                },
                child: Container(
                  width: Get.width * 0.2,
                  height: Get.height * 0.04,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 17,
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

class CustomTextField extends StatelessWidget {
  final Function validator;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  CustomTextField(
      {this.label, this.controller, this.validator, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: Get.height * 0.071 - 0.01,
      width: Get.width * 0.69,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontStyle: FontStyle.italic),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            )),
      ),
    );
  }
}

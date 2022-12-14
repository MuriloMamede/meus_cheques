import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/bankAccount_model.dart';
import 'package:intl/intl.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:meuscheques/app/theme/colors.dart';

class ChequeCreator extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final itemHeight = Get.height * 0.071;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void showDatPicker() async {
      final date = await showDatePicker(
        context: context,
        initialDate: _homeController.date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2150),
        helpText: "Selecione data vencimento",
        locale: Localizations.localeOf(context),
      );
      if (date != null) {
        _homeController.dateS.value =
            DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(date);

        _homeController.date = date;
      }
    }

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
        // height: itemHeight * 4.9,
        width: Get.width * 0.71,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  width: Get.width * 0.69,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Data vencimento:" + '\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87)),
                            TextSpan(
                                text: _homeController.dateS.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: Colors.black87)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: showDatPicker,
                        child: Icon(
                          Icons.edit,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              CustomTextField(
                label: 'Destinat??rio',
                controller: _homeController.chequeDestController,
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
                controller: _homeController.chequeValorController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true)
                ],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatorio";
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: 'N??mero',
                keyboardType: TextInputType.number,
                controller: _homeController.chequeNumberController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatorio";
                  } else if (int.tryParse(value) == null) {
                    return "Deve ser apenas n??meros";
                  }
                  return null;
                },
              ),
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
                                                    .accountSelected
                                                    .value
                                                    .bank
                                                    .name,
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
                  if (_homeController.dateS.value != "" &&
                      _homeController.accountSelected.value.accountName !=
                          null) {
                    if (_formKey.currentState.validate()) {
                      _homeController.saveCheque();
                      Get.back();
                    }
                  } else if (_homeController
                          .accountSelected.value.accountName ==
                      null)
                    showSnackBar("Ops..", "Selecione a conta banc??ria!");
                  else if (_homeController.dateS.value == "")
                    showSnackBar("Ops..", "Selecione a data de vencimento!");
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
  final List<TextInputFormatter> inputFormatters;

  CustomTextField({
    this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //height: Get.height * 0.071 - 0.01,
      width: Get.width * 0.69,
      child: TextFormField(
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(15), //

            labelStyle: TextStyle(fontStyle: FontStyle.italic),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            )),
      ),
    );
  }
}

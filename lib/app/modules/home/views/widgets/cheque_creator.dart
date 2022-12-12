import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meuscheques/app/data/model/cheque_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/global/widgets/pop_menu_selector.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:meuscheques/app/theme/colors.dart';

import 'dialog_textfield.dart';

class ChequeCreator extends StatelessWidget {
  ChequeCreator({Key? key, this.cheque}) : super(key: key);
  final Cheque? cheque;
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
        helpText: 'Selecione data vencimento',
        locale: Localizations.localeOf(context),
        //initialEntryMode: DatePickerEntryMode.input,
      );
      if (date != null) {
        _homeController.dateS.value =
            DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(date);

        _homeController.date = date;
      }
    }

    return CustomDialogWidget(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      title: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: primaryColor,
          ),
          child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Novo Cheque',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))),
      content: SizedBox(
        // height: itemHeight * 4.9,
        width: Get.width * 0.71,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Data vencimento:\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black87)),
                              TextSpan(
                                  text: _homeController.dateS.value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.black87)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: showDatPicker,
                          child: const Icon(
                            Icons.today,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                CustomTextField(
                  label: 'Destinatário',
                  textInputAction: TextInputAction.next,
                  controller: _homeController.chequeDestController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  //colocar receber valor formatado em real
                  label: 'Valor',
                  keyboardType: TextInputType.number,
                  controller: _homeController.chequeValorController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(moeda: true)
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textInputAction: TextInputAction.done,
                  label: 'Número',
                  keyboardType: TextInputType.number,
                  controller: _homeController.chequeNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatorio';
                    } else if (int.tryParse(value) == null) {
                      return 'Deve ser apenas números';
                    }
                    return null;
                  },
                ),
                Obx(() => PopMenuSelector(
                      itens: _homeController.accountItens,
                      horizontalPadding: 13,
                      textColor: Colors.black54,
                      iconColor: Colors.white,
                      widgetSelected: _homeController
                                  .chequeAccountSelected.value.accountName !=
                              null
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: _homeController
                                          .chequeAccountSelected
                                          .value
                                          .accountName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black87)),
                                  TextSpan(
                                      text: '\n' +
                                          _homeController.chequeAccountSelected
                                              .value.bank.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                          color: Colors.black87)),
                                  TextSpan(
                                      text: '\n' +
                                          _homeController.chequeAccountSelected
                                              .value.accountNumber
                                              .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                          color: Colors.black87)),
                                ],
                              ),
                            )
                          : Text(
                              _homeController.titleConta.value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                      height: Get.height * 0.07,
                      borderColor: Colors.black26,
                      onSelected: (dynamic s) {
                        var accountSelected = s;
                        _homeController.chequeAccountSelected.value =
                            accountSelected;
                      },
                      textSelected: _homeController.selectedChequeStatus.value,
                    )),
                Obx(() => PopMenuSelector(
                      itens: _homeController.statusList,
                      horizontalPadding: 13,
                      textColor: Colors.black54,
                      iconColor: Colors.white,
                      height: Get.height * 0.07,
                      borderColor: Colors.black26,
                      onSelected: (dynamic s) {
                        _homeController.selectedChequeStatus.value = s;
                      },
                      textSelected: _homeController.selectedChequeStatus.value,
                    )),
              ],
            ),
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
                  Get.back();
                },
                child: Container(
                  height: Get.height * 0.06,
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          fontSize: 16,
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
                  if (_homeController.dateS.value != '' &&
                      _homeController.chequeAccountSelected.value.accountName !=
                          null) {
                    if (_formKey.currentState!.validate()) {
                      _homeController.saveCheque(chque: cheque);
                    }
                  } else if (_homeController
                          .chequeAccountSelected.value.accountName ==
                      null) {
                    showSnackBar('Atenção..', 'Selecione a conta bancária!');
                  } else if (_homeController.dateS.value == '') {
                    showSnackBar(
                        'Atenção..', 'Selecione a data de vencimento!');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: Get.height * 0.06,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 16,
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

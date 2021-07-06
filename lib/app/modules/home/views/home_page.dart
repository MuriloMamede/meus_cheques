import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/constants.dart';

import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/modules/home/views/widgets/account_list.dart';
import 'package:meuscheques/app/modules/home/views/widgets/cheque_creator.dart';
import 'package:meuscheques/app/modules/home/views/widgets/cheque_listTile.dart';
import 'package:meuscheques/app/theme/colors.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();
  final BoxDecoration bordaVerde = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border(
      bottom: BorderSide(
        width: 1.0,
        color: Colors.green.shade300,
      ),
      top: BorderSide(
        width: 1.0,
        color: Colors.green.shade300,
      ),
      left: BorderSide(
        width: 1.0,
        color: Colors.green.shade300,
      ),
      right: BorderSide(
        width: 1.0,
        color: Colors.green.shade300,
      ),
    ),
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    void openAccountLister() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AccountList();
        },
      );
    }

    void openChequeCreator() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          controller.clearControllers();
          return ChequeCreator();
        },
      );
    }

    void openYearSelector() {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          controller.clearControllers();
          return Center(
            child: Container(
              height: Get.height * 0.3,
              width: Get.width * 0.7,
              child: Card(
                child: YearPicker(
                  selectedDate: controller.selectedYear.value,
                  onChanged: (date) {
                    controller.selectedYear.value = date;
                    controller.getCheques();
                    Get.back();
                  },
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2150),
                ),
              ),
            ),
          );
        },
      );
    }

/*GestureDetector(
            onHorizontalDragUpdate: (details) {
              // Note: Sensitivity is integer used when you don't want to mess up vertical drag
              int sensitivity = 8;
              if (details.delta.dx > sensitivity) {
                // Right Swipe

              } else if (details.delta.dx < -sensitivity) {
                //Left Swipe
              }
            },*/
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      floatingActionButton: FloatingActionButton(
        onPressed: openChequeCreator,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Meus Cheques'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: PopupMenuButton<String>(
              onSelected: (String s) {
                if (s == 'editRota') {
                } else if (s == 'sair') {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        actions: [
                          FlatButton(
                            child: Text(
                              "Não",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          FlatButton(
                            color: Colors.red.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Sim",
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                            onPressed: () {
                              _homeController.signOut();
                            },
                          ),
                        ],
                        title: Text(
                          'Deseja mesmo sair?',
                          textAlign: TextAlign.start,
                          style: TextStyle(),
                        ),
                        content: SizedBox(
                          height: 0,
                        ),
                      );
                    },
                  );
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              //onSelected: _select,
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                    value: 'editRota',
                    child: Text(
                      'Editar',
                      textAlign: TextAlign.left,
                    )),
                PopupMenuItem<String>(
                    value: 'sair',
                    child: Text(
                      'Sair',
                      textAlign: TextAlign.left,
                    )),
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                CommunityMaterialIcons.bank,
                color: Colors.white,
              ),
              onPressed: openAccountLister)
        ],
      ),
      //bottomNavigationBar: CustomBottomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => InkWell(
                            onTap: openYearSelector,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 15), //width: Get.width * 0.69,
                              height: Get.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          dateFormAno.format(_homeController
                                              .selectedYear.value),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green.shade300,
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: primaryColor,
                                        )),
                                  ),
                                ],
                              ),
                              decoration: bordaVerde,
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Obx(() => PopupMenuButton<DateTime>(
                            onSelected: (DateTime mes) {
                              _homeController.selectedMonth.value = mes;
                              controller.getCheques();
                            },
                            child: Container(
                              //width: Get.width * 0.69,
                              height: Get.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          dateFormMes.format(_homeController
                                              .selectedMonth.value),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green.shade300,
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: primaryColor,
                                        )),
                                  ),
                                ],
                              ),
                              decoration: bordaVerde,
                            ),
                            itemBuilder: (context) => controller.monthItens)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Obx(() => PopupMenuButton<DateTime>(
                        onSelected: (DateTime mes) {
                          _homeController.selectedMonth.value = mes;
                          controller.getCheques();
                        },
                        child: Container(
                          //width: Get.width * 0.69,
                          height: Get.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Conta selecionada',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.green.shade300,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: primaryColor,
                                    )),
                              ),
                            ],
                          ),
                          decoration: bordaVerde,
                        ),
                        itemBuilder: (context) => controller.monthItens)),
                  ),
                ],
              ),
            ),
            GetX<HomeController>(
              initState: (_) {},
              builder: (_) {
                try {
                  return Expanded(
                    child: Container(
                        child: RefreshIndicator(
                      onRefresh: controller.getCheques,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var cheque = _.cheques[index];

                          return ChequeListTile(cheque);
                        },
                        itemCount: _.cheques.length,
                      ),
                    )),
                  );
                } catch (e) {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '/app/data/model/cheque_model.dart';
import '/app/modules/home/controllers/home_controller.dart';
import '/app/modules/home/views/widgets/cheque_creator.dart';
import 'widgets/cheque_list_tile.dart';
import '/app/theme/colors.dart';
import 'widgets/action_bottom_sheet.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/drawer_menu.dart';
import 'widgets/filter_dialog.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();

  final BoxDecoration bordaVerde = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      width: 1,
      color: primaryColor,
    ),
    color: Colors.white,
  );

  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    void openFilterCheques() async {
      await showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.slideFromRight,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.2),
        builder: (BuildContext context) {
          return FilterDialog();
        },
      );
    }

    Future<DateTime?> setChequeVencimento() async {
      final date = await showDatePicker(
        context: context,
        initialDate: _homeController.date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2150),
        helpText: 'Selecione data vencimento',
        locale: Localizations.localeOf(context),
        //initialEntryMode: DatePickerEntryMode.input,
      );

      return date;
    }

    void showChequeDialog({cheque}) {
      showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.sizeFade,
        barrierDismissible: true,
        builder: (BuildContext context) {
          controller.clearControllers();

          if (cheque != null) {
            _homeController.setControllers(cheque);
          } else {
            _homeController.chequeAccountSelected.value =
                _homeController.selectedAccount.value;
            _homeController.dateS();
          }

          return ChequeCreator(
            cheque: cheque,
          );
        },
      );
    }

    void openChequeCreator({cheque}) async {
      if (cheque == null) {
        var date = await setChequeVencimento();
        if (date != null) {
          _homeController.dateS.value = dateFormddMMMyy.format(date);
          _homeController.date = date;
        }
      }
      showChequeDialog(cheque: cheque);
    }

    void showBottomSheet(Cheque cheque) {
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.3),
          builder: (context) {
            return ActionBottomSheet(
              onEditTap: () {
                Get.back();
                openChequeCreator(cheque: cheque);
              },
              onRemoveTap: () => controller.removeCheque(cheque),
            );
          });
    }

    return Obx(
      () => SideMenu(
        key: controller.sideMenuKey.value,
        menu: const Menu(),
        type: SideMenuType.slideNRotate,
        background: primaryColor,
        //TODO: adicionar container em cima do sacaffold quando drawer estiver aberta
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Obx(() => CustomBottomBar(
                qtdCheques: controller.cheques.length,
                totalCheques: controller.totalCheques.value,
              )),
          backgroundColor: Colors.grey.shade100,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: openChequeCreator,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () =>
                  controller.sideMenuKey.value.currentState!.openSideMenu(),
            ),
            title: const Text('Meus Cheques'),
            actions: [
              IconButton(
                onPressed: openFilterCheques,
                icon: const Icon(
                  CommunityMaterialIcons.filter_menu_outline,
                  color: Colors.white,
                ),
              ),
              /* PopupMenuButton<String>(
                padding: EdgeInsets.all(0),
                onSelected: (String s) {
                  if (s == 'alpha_asc') {}
                  if (s == 'alpha_desc') {}
                  if (s == 'number_asc') {}
                  if (s == 'number_desc') {}
                  if (s == 'date_asc') {}
                  if (s == 'date_desc') {}
                },
                icon: Icon(
                  CommunityMaterialIcons.tune_variant,
                  color: Colors.white,
                ),
               
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                      value: 'date_desc',
                      child: Row(
                        children: [
                          Icon(
                            CommunityMaterialIcons.sort_calendar_ascending,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Data vencimento'),
                          )
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'date_asc',
                      child: Row(
                        children: [
                          Icon(
                            CommunityMaterialIcons.sort_calendar_descending,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Data vencimento'),
                          )
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'number_desc',
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.sortNumericDown,
                            color: Colors.black54,
                            size: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Num. cheque'),
                          )
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'number_asc',
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.sortNumericUpAlt,
                            color: Colors.black54,
                            size: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Num. cheque'),
                          )
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'alpha_desc',
                      //textStyle: TextStyle(color: primaryColor),
                      child: Row(
                        children: [
                          Icon(
                            CommunityMaterialIcons.sort_alphabetical_ascending,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Destinatário'),
                          )
                        ],
                      )),
                  PopupMenuItem<String>(
                      value: 'alpha_asc',
                      child: Row(
                        children: [
                          Icon(
                            CommunityMaterialIcons.sort_alphabetical_descending,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Destinatário'),
                          )
                        ],
                      )),
                ],
              ),
*/
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => InkWell(
                              onTap: () => openDateRangeSelector(),
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Cheques de',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            dateFormddMM.format(_homeController
                                                    .initialDate.value) +
                                                " à " +
                                                dateFormddMM.format(
                                                    _homeController
                                                        .finalDate.value),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: primaryColor,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                decoration: bordaVerde,
                              ),
                            )),
                      ],
                    ),
                    Obx(() => PopMenuSelector(
                          itens: controller.statusList,
                          onSelected: (dynamic status) {
                            controller.selectedStatus.value = status;
                            controller.getCheques();
                          },
                          textSelected: controller.selectedStatus.value,
                        )),
                    Obx(() => PopMenuSelector(
                          itens: controller.accountItens,
                          onSelected: (dynamic account) {
                            controller.selectedAccount.value = account;
                            controller.getCheques();
                          },
                          textSelected: controller
                                      .selectedAccount.value.accountName !=
                                  null
                              ? controller.selectedAccount.value.accountName!
                              : 'Todas',
                        )),
                  ],
                ),
                */
                GetX<HomeController>(
                  initState: (_) {},
                  builder: (_) {
                    try {
                      return Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: RefreshIndicator(
                              onRefresh: controller.getCheques,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var cheque = _.cheques[index];

                                  return ChequeListTile(
                                    cheque,
                                    onTap: () => showBottomSheet(cheque),
                                    labelColor: _.colors[
                                        _.getAccountIndex(cheque.account)],
                                  );
                                },
                                itemCount: _.cheques.length,
                              ),
                            )),
                      );
                    } catch (e) {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

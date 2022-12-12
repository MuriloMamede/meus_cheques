import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/modules/home/controllers/home_controller.dart';
import 'package:meuscheques/app/theme/colors.dart';
import 'expandable_component.dart';
import 'filter_acount_list_tile.dart';
import 'multi_selectable_filter_list_tile.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({
    Key? key,
  }) : super(key: key);
  final _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    void openDateSelector(bool isInitial) async {
      String helpText = '';
      late DateTime dateDisplay;
      if (isInitial) {
        dateDisplay = _homeController.initialDate.value;
        helpText = 'Selecione a data inicial para filtragem';
      } else {
        dateDisplay = _homeController.finalDate.value;
        helpText = 'Selecione a data final para filtragem';
      }
      final date = await showDatePicker(
        context: context,
        initialDate: dateDisplay,

        firstDate: DateTime(1900),
        lastDate: DateTime(2150),
        helpText: helpText,
        locale: Localizations.localeOf(context),
        //initialEntryMode: DatePickerEntryMode.input,
      );
      if (date != null) {
        if (isInitial) {
          _homeController.initialDate.value = date;
        } else {
          _homeController.finalDate.value = date;
        }
        _homeController.getCheques();
      }
    }

    String getTitleAccountSelected() {
      var listItens = _homeController.accountsSelected;

      String title = '';

      int totalSelected = 0;
      for (var filter in listItens) {
        if (filter.isSelected) {
          totalSelected++;
          title += "${filter.account.accountName ?? " "}; ";
        }
      }
      if (totalSelected == 0) {
        return 'Nenhum';
      }
      return totalSelected == listItens.length ? 'Todos' : title;
    }

    String getTitleStatusSelected() {
      var listItens = _homeController.statusSelected;
      String title = '';

      int totalSelected = 0;
      for (var filter in listItens) {
        if (filter.isSelected) {
          totalSelected++;
          title += '${filter.status}; ';
        }
      }
      if (totalSelected == 0) {
        return 'Nenhum';
      }
      return totalSelected == listItens.length ? 'Todos' : title;
    }

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight * 1.7),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14), topLeft: Radius.circular(14)),
          child: Material(
            child: Container(
              color: Colors.grey.shade200,
              height: Get.height * 0.6,
              width: Get.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: kToolbarHeight * 0.7,
                    width: Get.width * 0.7,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(1, 0))
                      ],
                    ),
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Filtrar por:',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilterButton(
                              filterTitle: 'Data Inicial:',
                              filterSelected: dateFormddMMMyy
                                  .format(_homeController.initialDate.value),
                              customIcon: Icons.event_outlined,
                              onTap: () => openDateSelector(true),
                            ),
                            Container(
                              color: Colors.white,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.black12,
                                height: 1,
                              ),
                            ),
                            FilterButton(
                              filterTitle: 'Data Final:',
                              filterSelected: dateFormddMMMyy
                                  .format(_homeController.finalDate.value),
                              customIcon: Icons.event_outlined,
                              onTap: () => openDateSelector(false),
                            ),
                            const SizedBox(
                              height: 1.5,
                            ),
                            Obx(() => ExpandableFilterComponent(
                                  filterTitle: 'Ordenar por:',
                                  filterSelected: _homeController
                                      .ordenationSelected.value.label,
                                  onTap: (value) {
                                    _homeController.ordenationSelected(value);
                                  },
                                  filtroSelected:
                                      _homeController.ordenationSelected.value,
                                  filtros: ORDENATION_LIST,
                                )),
                            Obx(
                              () => ExpandableFilterComponent(
                                filterTitle: 'Status:',
                                filterSelected: getTitleStatusSelected(),
                                isMultiSelect: true,
                                filtros: const [],
                                filtersChildren: _homeController.statusSelected
                                    .map((status) =>
                                        MultiSelectableFilterListTile(
                                          Text(status.status),
                                          value: status.isSelected,
                                          onTap: () => _homeController
                                              .selectFilterStatus(status),
                                        ))
                                    .toList(),
                              ),
                            ),
                            Obx(
                              () => ExpandableFilterComponent(
                                filterTitle: 'Selecionar conta:',
                                filterSelected: getTitleAccountSelected(),
                                filtros: const [],
                                filtersChildren:
                                    _homeController.accountsSelected
                                        .map((account) => FilterAccountListTile(
                                              account,
                                              onTap: () => _homeController
                                                  .selectFilterAccount(account),
                                            ))
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.filterTitle,
    required this.filterSelected,
    this.onTap,
    this.customIcon,
    Key? key,
  }) : super(key: key);
  final String filterTitle;
  final String? filterSelected;
  final IconData? customIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        customIcon,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filterTitle,
                          style: const TextStyle(fontSize: 13),
                        ),
                        filterSelected != null
                            ? Text(
                                filterSelected!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 11,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                )
              ],
            )),
      ),
    );
  }
}

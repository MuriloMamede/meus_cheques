import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:meuscheques/app/data/model/filtro_model.dart';
import 'package:meuscheques/app/theme/colors.dart';

class ExpandableFilterComponent extends StatelessWidget {
  const ExpandableFilterComponent(
      {Key? key,
      required this.filterTitle,
      required this.filtros,
      this.filtroSelected,
      this.onTap,
      this.isMultiSelect,
      this.filterSelected,
      this.filtersChildren,
      this.customIcon})
      : super(key: key);
  final List<Filtro> filtros;
  final Filtro? filtroSelected;
  final String filterTitle;
  final String? filterSelected;
  final bool? isMultiSelect;
  final IconData? customIcon;
  final Function(dynamic value)? onTap;
  final List<Widget>? filtersChildren;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Container(
        color: Colors.black12,
        height: 1,
      ),
    ];
    children.addAll(filtersChildren ??
        List.generate(
            filtros.length,
            (index) => Material(
                  child: InkWell(
                    onTap: () {
                      onTap!(filtros[index]);
                    },
                    child: Container(
                      width: Get.width * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.05),
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5))),
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(filtros[index].label),
                          Radio(
                            value: filtros[index],
                            groupValue: filtroSelected,
                            onChanged: (value) => onTap!(value),
                          )
                        ],
                      ),
                    ),
                  ),
                )));

    return ExpandableNotifier(
        child: Container(
      margin: const EdgeInsets.only(
        bottom: 1.5,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(top: 3),
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: true,
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
                tapBodyToExpand: false,
                hasIcon: customIcon == null,
              ),
              header: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                customIcon,
                                color: primaryColor,
                                size: 24,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        child: Column(
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
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  )),
              collapsed: const SizedBox(),
              expanded: SizedBox(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children)),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

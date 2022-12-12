import 'package:flutter/material.dart';
import 'package:meuscheques/app/data/model/account_filter.dart';
import 'package:meuscheques/app/modules/home/views/widgets/multi_selectable_filter_list_tile.dart';

class FilterAccountListTile extends StatelessWidget {
  const FilterAccountListTile(
    this.bankAccount, {
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final AccountFilter bankAccount;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return MultiSelectableFilterListTile(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bankAccount.account.accountName ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            bankAccount.account.bank.name,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Colors.black87),
          ),
          Text(
            bankAccount.account.accountNumber.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Colors.black87),
          )
        ],
      ),
      onTap: onTap,
      value: bankAccount.isSelected,
    );
  }
}

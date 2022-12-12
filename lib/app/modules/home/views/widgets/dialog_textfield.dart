import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuscheques/app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool autofocus;
  final String? prefixText;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String?)? onFieldSubmitted;
  final String? initialValue;
  const CustomTextField({
    Key? key,
    this.validator,
    this.label,
    this.controller,
    this.autofocus = false,
    this.keyboardType,
    this.onChanged,
    this.autovalidateMode,
    this.inputFormatters,
    this.readOnly = false,
    this.prefixText,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      margin: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Column(
                  children: [
                    Text(
                      label!,
                      style: const TextStyle(
                          fontSize: 14, color: darkPrimaryColor),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                )
              : const SizedBox(),
          Theme(
            data: ThemeData(
              primaryColor: primaryColor,
              primarySwatch: primaryColor,
            ),
            child: TextFormField(
              onTap: onTap,
              readOnly: readOnly,
              keyboardType: keyboardType ?? TextInputType.text,
              autovalidateMode:
                  autovalidateMode ?? AutovalidateMode.onUserInteraction,
              inputFormatters: inputFormatters,
              validator: validator,
              controller: controller,
              enabled: !readOnly,
              obscureText: obscureText,
              initialValue: initialValue,
              autofocus: autofocus,
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              style: TextStyle(
                color: !readOnly ? Colors.black : Colors.black54,
                fontSize: 16.5,
              ),
              textInputAction: textInputAction,
              decoration: InputDecoration(
                  prefixText: prefixText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  errorStyle: TextStyle(
                      fontSize: 12, color: Theme.of(context).errorColor),
                  contentPadding: const EdgeInsets.all(12),
                  labelStyle: const TextStyle(fontStyle: FontStyle.italic),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

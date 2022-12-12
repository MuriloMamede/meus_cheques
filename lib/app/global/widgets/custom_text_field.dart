import 'package:flutter/material.dart';
import 'package:meuscheques/app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? toggle;
  final Function()? onEditingComplete;
  final IconData? icon;
  final String hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green.shade800, width: 1),
    borderRadius: const BorderRadius.all(
      Radius.circular(25),
    ),
  );

  CustomTextField(
      {Key? key, this.controller,
      this.onEditingComplete,
      required this.hintText,
      required this.icon,
      this.toggle,
      this.keyboardType,
      this.validator,
      this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      validator: validator,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10.0),
          focusedErrorBorder: border,
          errorBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          suffixIcon: obscureText != null
              ? obscureText == true
                  ? InkWell(
                      child: const Icon(
                        Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onTap: toggle,
                    )
                  : InkWell(
                      child: const Icon(
                        Icons.visibility,
                        color: primaryColor,
                      ),
                      onTap: toggle,
                    )
              : null,
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
          labelText: hintText,
          hintStyle: const TextStyle(color: Colors.black)),
    );
  }
}

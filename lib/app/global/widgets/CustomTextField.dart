import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meuscheques/app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Function toggle;
  final Function onEditingComplete;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green.shade800, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(25),
    ),
  );

  CustomTextField(
      {this.controller,
      this.onEditingComplete,
      this.hintText,
      this.icon,
      this.toggle,
      this.keyboardType,
      this.validator,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      controller: controller,
      validator: validator,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText == null ? false : obscureText,
      decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          focusedErrorBorder: border,
          errorBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          suffixIcon: obscureText != null
              ? obscureText == true
                  ? InkWell(
                      child: Icon(
                        Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onTap: toggle,
                    )
                  : InkWell(
                      child: Icon(
                        Icons.visibility,
                        color: primaryColor,
                      ),
                      onTap: toggle,
                    )
              : null,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: primaryColor,
                )
              : null,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.black)),
    );
  }
}

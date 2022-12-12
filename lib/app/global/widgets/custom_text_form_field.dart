import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String title;
  final Widget? suffix;
  final Function(String)? onChanged;
  final Icon? icon;
  final Function()? onEditingComplete;
  final Function()? toggle;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? helperText;
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.suffix,
    required this.title,
    this.icon,
    this.onEditingComplete,
    this.obscureText,
    this.onChanged,
    this.helperText,
    this.inputFormatters,
    this.keyboardType,
    this.toggle,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color color = primaryColor;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.black,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        validator: validator,
        obscureText: obscureText ?? false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            suffix: suffix,
            prefixIcon: icon ??
                const Icon(
                  Icons.search,
                ),
            suffixIcon: obscureText != null
                ? obscureText == false
                    ? InkWell(
                        child: const Icon(
                          Icons.visibility_off,
                        ),
                        onTap: toggle,
                      )
                    : InkWell(
                        child: const Icon(
                          Icons.visibility,
                        ),
                        onTap: toggle,
                      )
                : null,
            floatingLabelStyle: const TextStyle(color: color),
            helperText: helperText,
            errorStyle: const TextStyle(color: Colors.red),
            filled: false,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: color),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            labelText: title,
            hintStyle: const TextStyle(color: Colors.black)),
      ),
    );
  }
}

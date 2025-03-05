import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

typedef Validator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Validator validate;
  final String label;
  final TextInputType keyboardType;
  final bool obsure;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final int maxLines;
  final bool? readOnly;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.validate,
      required this.label,
      required this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.obsure = false,
      this.suffixIcon,
      this.onTap,
      this.maxLines = 1,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          validator: validate,
          keyboardType: keyboardType,
          obscureText: obsure,
          maxLines: maxLines,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIconConstraints: maxLines > 1
                  ? BoxConstraints(maxWidth: 60, minHeight: 140)
                  : null,
              labelText: label,
              prefixIcon: prefixIcon,
              prefixIconColor: MyTheme.primaryColor,
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(width: 1.5, color: MyTheme.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: MyTheme.redColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(width: 1.5, color: MyTheme.primaryColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: MyTheme.redColor)))),
    );
  }
}

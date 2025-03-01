import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

typedef Validator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  Validator validate;
  String label;
  TextInputType keyboardType;
  bool obsure;
  Widget prefixIcon;
  Widget? suffixIcon;
  CustomTextFormField(
      {super.key,
      required this.controller,
      required this.validate,
      required this.label,
      required this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.obsure = false,
      this.suffixIcon = null});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
          controller: controller,
          validator: validate,
          keyboardType: keyboardType,
          obscureText: obsure,
          decoration: InputDecoration(
              labelText: label,
              prefixIcon: prefixIcon,
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

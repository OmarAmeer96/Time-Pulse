import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

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
    var theme = context.read<ThemeCubit>();
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
              labelStyle: TextStyle(
                  color: theme.darkMode ? Colors.white : Colors.black,
                  fontSize: 20),
              prefixIcon: prefixIcon,
              prefixIconColor: Theme.of(context).colorScheme.primary,
              suffixIcon: suffixIcon,
              suffixIconColor: theme.darkMode ? Colors.white : Colors.black,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.primary)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.primary)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary)))),
    );
  }
}

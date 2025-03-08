import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.onChanged,
    this.onSubmitted,
  });

  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: controller,
        cursorColor: MyTheme.primaryColor,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(icon, color: MyTheme.primaryColor),
            onPressed: () => onSubmitted?.call(controller.text),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: MyTheme.primaryColor),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: MyTheme.primaryColor),
    );
  }
}
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText, required this.controller, this.icon, this.onSubmitted});

  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Color(0xff80c6c5),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(icon, color: Color(0xff80c6c5)),
          onPressed: onSubmitted
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff80c6c5)),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xff80c6c5)));
  }
}

import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyTheme.primaryColor,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                width: 20,
              ),
              icon
            ],
          )),
    );
  }
}

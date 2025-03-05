import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Color containerColor;
  final VoidCallback onTap;
  const CustomContainer(
      {super.key,
      required this.onTap,
      required this.text,
      required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: containerColor,
          ),
          child: Text(
            text,
            style: TextStyle(
                color: (containerColor == MyTheme.primaryColor)
                    ? Colors.white
                    : Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}

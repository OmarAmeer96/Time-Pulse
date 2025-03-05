import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class GlobalDialog {
  static showLoadingDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: MyTheme.primaryColor,
              ),
              SizedBox(width: 15),
              Text("Loading")
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class GlobalDialog {
  static showLoadingDialog(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15),
              Text("Loading")
            ],
          ),
        );
      },
    );
  }
}

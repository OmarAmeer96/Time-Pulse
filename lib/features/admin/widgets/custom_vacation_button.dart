import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

class CustomVacationButton extends StatelessWidget {
  const CustomVacationButton({super.key, this.isAccept = true, required this.onPressed});

  final bool isAccept;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: isAccept ? MyTheme.primaryColor : MyTheme.redColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isAccept
              ? Text(
                  'Accept',
                  style: TextStyle(color: Colors.white,
                  fontSize: 16
                  ),
                )
              : Text(
                  'Reject',
                  style: TextStyle(color: Colors.white,
                  fontSize: 16
                  ),
                ),
        ),
      ),
    );
  }
}

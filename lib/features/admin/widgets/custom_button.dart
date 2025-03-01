import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Color(0xff80c6c5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Create',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}

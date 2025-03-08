import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            icon,
          ],
        ),
      ),
    );
  }
}

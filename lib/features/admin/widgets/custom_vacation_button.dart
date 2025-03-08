import 'package:flutter/material.dart';
import 'package:time_pulse/generated/l10n.dart';

class CustomVacationButton extends StatelessWidget {
  const CustomVacationButton({
    Key? key,
    this.isAccept = true,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final bool isAccept;
  final GestureTapCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: isAccept
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  isAccept ? S.of(context).accept : S.of(context).reject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}

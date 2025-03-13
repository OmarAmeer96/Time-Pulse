import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

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
                color: (containerColor == Theme.of(context).colorScheme.primary)
                    ? Colors.white
                    : context.read<ThemeCubit>().darkMode
                        ? Colors.white70
                        : Colors.black,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}

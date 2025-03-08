import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

class GlobalDataShow extends StatelessWidget {
  final String title;
  final String data;
  const GlobalDataShow({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.read<ThemeCubit>();
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withValues(alpha: theme.darkMode ? 0.5 : 0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary),
          ),
          // SizedBox(width: 3),
          Text(
            data,
            style: TextStyle(
                fontSize: 12,
                color: theme.darkMode ? Colors.black54 : Colors.black),
          )
        ],
      ),
    );
  }
}

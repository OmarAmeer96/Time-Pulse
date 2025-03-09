import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/data/extensions/extensions.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.employeeName,
      required this.employeeRemainingLeaves,
      required this.onTap});

  final String employeeName;
  final String employeeRemainingLeaves;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withValues(alpha: 0.1)),
        height: 70,
        child: ListTile(
          leading: Icon(Icons.person,
              color: Theme.of(context).colorScheme.primary, size: 30),
          title: Text(employeeName,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          subtitle: Text(employeeRemainingLeaves,
              style: TextStyle(
                  color: context.read<ThemeCubit>().darkMode
                      ? Colors.white
                      : Colors.black,
                  fontSize: 10)),
          trailing: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.read<ThemeCubit>().darkMode
                  ? Colors.white
                  : Colors.black,
              size: 15,
            ),
          ),
        ),
      ).decorate(padding: 4, context: context),
    );
  }
}

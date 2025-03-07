import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';

extension CustomBoxDecoration on Widget {
  Widget decorate({double? padding , required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          color: context.read<ThemeCubit>().darkMode?Colors.grey.shade400:Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF767676).withValues(alpha: 0.1),
              blurRadius: 7,
              offset: const Offset(0, 6),
            ),
          ]),
      child: this,
    );
  }
}

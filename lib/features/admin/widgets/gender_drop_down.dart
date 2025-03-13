import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/admin/cubit/admin_cubit/admin_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      isExpanded: true,
      underline: SizedBox(),
      padding: EdgeInsets.symmetric(horizontal: 12),
      value: context.read<AdminCubit>().employeeGender,
      items: [
        DropdownMenuItem<String>(
          value: "Male",
          child: Row(
            children: [
              Icon(Icons.boy_sharp,
                  color: Theme.of(context).colorScheme.primary),
              SizedBox(
                width: 5,
              ),
              Text(S.of(context).male),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: "Female",
          child: Row(
            children: [
              Icon(
                Icons.girl_sharp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text(S.of(context).female),
            ],
          ),
        )
      ],
      onChanged: (newValue) {
        context.read<AdminCubit>().selectEmployeeGender(newValue!);
      },
    );
  }
}

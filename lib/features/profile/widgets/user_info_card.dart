import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/profile/widgets/info_row_item.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

Widget buildUserInfoCard(
  Map<String, dynamic> userData,
  BuildContext context,
) {
  return Card(
    color: context.read<ThemeCubit>().darkMode
        ? Colors.grey.shade400
        : Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          infoRowItem(
            '${S.of(context).employee_id}: ',
            userData['ID'] ?? 'N/A',
          ),
          const Divider(height: 30),
          infoRowItem(
            '${S.of(context).position}: ',
            userData['position'] ?? S.of(context).not_specified,
          ),
          const Divider(height: 30),
          infoRowItem(
            '${S.of(context).department}: ',
            userData['department'] ?? S.of(context).general,
          ),
          const Divider(height: 30),
          infoRowItem(
            '${S.of(context).vacation_balance}: ',
            userData['remaining_leaves'].toString(),
          ),
        ],
      ),
    ),
  );
}

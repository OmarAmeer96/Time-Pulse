import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/generated/l10n.dart';

Widget buildLogoutButton(
  BuildContext context,
  VoidCallback onPressed,
) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      icon: const Icon(Icons.logout, color: Colors.white),
      label: Text(
        S.of(context).logout,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

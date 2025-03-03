import 'package:flutter/material.dart';
import 'package:time_pulse/features/profile/widgets/info_row_item.dart';

Widget buildUserInfoCard(Map<String, dynamic> userData) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          infoRowItem('Employee ID', userData['ID'] ?? 'N/A'),
          const Divider(height: 30),
          infoRowItem('Position', userData['position'] ?? 'Not specified'),
          const Divider(height: 30),
          infoRowItem('Department', userData['department'] ?? 'General'),
        ],
      ),
    ),
  );
}

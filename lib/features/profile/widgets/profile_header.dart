import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

Widget buildProfileHeader(
  Map<String, dynamic> userData,
  BuildContext context,
) {
  var theme = context.read<ThemeCubit>();
  return Column(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
          ),
        ),
        child: ClipOval(
          child: userData['image_url']?.isNotEmpty == true
              ? Image.network(
                  userData['image_url'],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, size: 50),
                )
              : const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        userData['name'] ?? S.of(context).profile,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: theme.darkMode ? Colors.white : Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        userData['email'] ?? 'No Email Provided',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade600,
        ),
      ),
    ],
  );
}

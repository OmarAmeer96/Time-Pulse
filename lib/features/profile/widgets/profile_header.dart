import 'package:flutter/material.dart';
import 'package:time_pulse/core/theme.dart';

Widget buildProfileHeader(Map<String, dynamic> userData) {
  return Column(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: MyTheme.primaryColor,
            width: 3,
          ),
        ),
        child: ClipOval(
          child: userData['profilePictureUrl']?.isNotEmpty == true
              ? Image.network(
                  userData['profilePictureUrl'],
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
        userData['name'] ?? 'No Name Provided',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
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

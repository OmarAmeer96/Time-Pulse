import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UI for user',
            ),
            IconButton.filled(
              onPressed: () {
                Navigator.pushNamed(context, Routes.profileView);
              },
              icon: Icon(Icons.person),
              tooltip: 'Go to Profile',
            ),
          ],
        ),
      ),
    );
  }
}

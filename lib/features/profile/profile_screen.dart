import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/features/profile/widgets/logout_button.dart';
import 'package:time_pulse/features/profile/widgets/profile_header.dart';
import 'package:time_pulse/features/profile/widgets/user_info_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('employees').doc(user.uid).get();
      log('User UID: ${user.uid}');
      log('User Data: ${userDoc.data()}');
      return userDoc.data() as Map<String, dynamic>? ?? {};
    }
    return {};
  }

  void refreshUserData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshUserData,
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final userData = snapshot.data ?? {};

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildProfileHeader(userData),
                const SizedBox(height: 30),
                buildUserInfoCard(userData),
                const SizedBox(height: 30),
                buildLogoutButton(
                  context,
                  () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, Routes.loginView);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

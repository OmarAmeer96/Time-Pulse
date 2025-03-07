import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/features/profile/cubit/profile_cubit.dart';
import 'package:time_pulse/features/profile/widgets/logout_button.dart';
import 'package:time_pulse/features/profile/widgets/profile_header.dart';
import 'package:time_pulse/features/profile/widgets/user_info_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      )..fetchUserData(),
      child: Scaffold(
        appBar: GlobalAppbar(title: "Profile"),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final userData = state.userData;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    buildProfileHeader(userData, context),
                    const SizedBox(height: 30),
                    buildUserInfoCard(userData, context),
                    const SizedBox(height: 30),
                    buildLogoutButton(
                      context,
                      () async {
                        await context.read<ProfileCubit>().signOut();
                        SharedPrefHelper.setData("isUserLoggedIn", false);
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.loginView,
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

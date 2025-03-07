import 'package:flutter/material.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
import 'package:time_pulse/core/routing/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoggedIn = false;
  bool isAdmin = false;

  Future<void> checkLoginStatus() async {
    isLoggedIn = await SharedPrefHelper.getBool("isUserLoggedIn");
    isAdmin = await SharedPrefHelper.getBool("isAdmin");
  }

  @override
  void initState() {
    checkLoginStatus();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        !isLoggedIn
            ? Routes.loginView
            : !isAdmin
                ? Routes.mainView
                : Routes.adminView,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/logo_icon.png')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.loginView);
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

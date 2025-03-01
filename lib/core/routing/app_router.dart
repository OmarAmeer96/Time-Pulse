import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/features/admin/views/admin_home_view.dart';
import 'package:time_pulse/features/splash/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // This arguments to be passed in any screen like this: (arguments as ClassName).
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      
      case Routes.adminHomeView:
        return MaterialPageRoute(
          builder: (_) => const AdminHomeView(),
        );

      default:
        return null;
    }
  }
}

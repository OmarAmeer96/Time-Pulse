import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/features/admin/admin_view.dart';
import 'package:time_pulse/features/auth/login/login_view.dart';
import 'package:time_pulse/features/splash/splash_view.dart';
import 'package:time_pulse/features/user/user_view.dart';

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
        case Routes.loginView:
        return MaterialPageRoute(
          builder: (_)=>const LoginView());
        case Routes.userView:
        return MaterialPageRoute(builder: (_)=>const UserView());
        case Routes.adminView:
        return MaterialPageRoute(builder: (_)=>const AdminView());
        

      default:
        return null;
    }
  }
}

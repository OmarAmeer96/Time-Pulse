import 'package:flutter/material.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/features/admin/admin_view.dart';
import 'package:time_pulse/features/admin/views/admin_vacations_requests_view.dart';
import 'package:time_pulse/features/admin/views/admin_vrv.dart';
import 'package:time_pulse/features/admin/views/employee_history_view.dart';
import 'package:time_pulse/features/auth/login/login_view.dart';
import 'package:time_pulse/features/main/main_view.dart';
import 'package:time_pulse/features/admin/views/admin_home_view.dart';
import 'package:time_pulse/features/profile/profile_screen.dart';
import 'package:time_pulse/features/splash/splash_view.dart';
import 'package:time_pulse/features/user/user_view.dart';
import 'package:time_pulse/features/vacation_request/vacation_request_view.dart';
import 'package:time_pulse/features/vacations_history/vacations_history_view.dart';

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
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.userView:
        return MaterialPageRoute(builder: (_) => const UserView());
      case Routes.adminView:
        return MaterialPageRoute(builder: (_) => const AdminView());
      case Routes.mainView:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.vacationsView:
        return MaterialPageRoute(builder: (_) => const VacationsHistoryView());
      case Routes.vacationRequestView:
        return MaterialPageRoute(builder: (_) => const VacationRequestView());
      case Routes.adminHomeView:
        return MaterialPageRoute(builder: (_) => const AdminHomeView());
      case Routes.profileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.adminVacationsView:
        return MaterialPageRoute(builder: (_) => const AdminVacationsRequestsView());
      case Routes.employeeHistoryView:
        return MaterialPageRoute(builder: (_) => const EmployeeHistoryView());
      case Routes.adminVrv:
        return MaterialPageRoute(builder: (_) => const AdminVrv());

      default:
        return null;
    }
  }
}

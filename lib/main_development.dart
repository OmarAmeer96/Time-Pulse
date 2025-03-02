import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_pulse/core/helpers/simple_bloc_observer.dart';
import 'package:time_pulse/core/routing/app_router.dart';
import 'package:time_pulse/time_pulse.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await ScreenUtil.ensureScreenSize();

  runApp(
    TimePulse(
      appRouter: AppRouter(),
    ),
  );
}

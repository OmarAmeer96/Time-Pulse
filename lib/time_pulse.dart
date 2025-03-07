import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_pulse/core/routing/app_router.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/core/theme.dart';
import 'package:time_pulse/features/history/cubit/history_cubit.dart';
import 'package:time_pulse/features/main/cubit/main_cubit.dart';
import 'package:time_pulse/features/profile/cubit/profile_cubit.dart';
import 'package:time_pulse/features/user/cubit/user_cubit.dart';
import 'package:time_pulse/features/vacation_request/cubit/vacation_request_cubit.dart';
import 'package:time_pulse/features/vacations_history/cubit/vacations_history_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class TimePulse extends StatelessWidget {
  final AppRouter appRouter;
  const TimePulse({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(create: (context) => HistoryCubit()),
          BlocProvider(create: (context) => VacationRequestCubit()),
          BlocProvider(create: (context) => VacationsHistoryCubit()),
          BlocProvider(create: (context) => MainCubit()),
          BlocProvider(
            create: (context) => ProfileCubit(
              FirebaseAuth.instance,
              FirebaseFirestore.instance,
            )..fetchUserData(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Time Pulse',
          onGenerateRoute: appRouter.generateRoute,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('en'),
          initialRoute: Routes.splashView,
          theme: MyTheme.lightMode,
          darkTheme: MyTheme.darkMode,
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}

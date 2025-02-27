import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_pulse/core/routing/app_router.dart';
import 'package:time_pulse/core/routing/routes.dart';
import 'package:time_pulse/generated/l10n.dart';

class TimePulse extends StatelessWidget {
  final AppRouter appRouter;
  const TimePulse({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
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
      ),
    );
  }
}

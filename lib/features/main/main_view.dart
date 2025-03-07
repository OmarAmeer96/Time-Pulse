import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/history/history_view.dart';
import 'package:time_pulse/features/main/cubit/main_cubit.dart';
import 'package:time_pulse/features/settings/settings_view.dart';
import 'package:time_pulse/features/profile/profile_view.dart';
import 'package:time_pulse/features/user/user_view.dart';
import 'package:time_pulse/features/vacations_history/vacations_history_view.dart';
import 'package:time_pulse/generated/l10n.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    UserView(),
    HistoryView(),
    VacationsHistoryView(),
    SettingsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[context.read<MainCubit>().currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: context.read<MainCubit>().currentIndex,
              onTap: (index) {
                context.read<MainCubit>().changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: S.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: S.of(context).history,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_timeline),
                  label: S.of(context).leaves,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: S.of(context).settings,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: S.of(context).profile,
                ),
              ],
            ),
        );
      },
    );
  }
}

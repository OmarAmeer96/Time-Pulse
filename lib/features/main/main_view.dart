import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/features/history/history_view.dart';
import 'package:time_pulse/features/main/cubit/main_cubit.dart';
import 'package:time_pulse/features/profile/profile_view.dart';
import 'package:time_pulse/features/user/user_view.dart';
import 'package:time_pulse/features/vacations_history/vacations_history_view.dart';

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
    Center(child: Text("Settings")),
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
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_timeline),
                label: "Vacations",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}

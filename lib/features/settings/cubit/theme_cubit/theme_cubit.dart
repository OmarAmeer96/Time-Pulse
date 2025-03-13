import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/shared_pref_helper.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  bool darkMode = false;

  ThemeCubit() : super(ThemeInitial());
  toggleTheme() async{
    darkMode = !darkMode;
    if (darkMode == true) {
      await SharedPrefHelper.setData("isDark", true);
      emit(DarkModeState());
    } else if (darkMode == false) {
      await SharedPrefHelper.setData("isDark", false);
      emit(LightModeState());
    }
  }
  detectTheme()async {
    darkMode = await SharedPrefHelper.getBool("isDark") ?? false;
    if (darkMode == true) {
      emit(DarkModeState());
    } else if (darkMode == false) {
      emit(LightModeState());
    }
  }
}

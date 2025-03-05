import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color.fromARGB(255, 14, 145, 145);
  static Color redColor = Color(0xffF54140);
  static ThemeData lightMode = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff0E9190),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff0E9190),
        selectedLabelStyle: TextStyle(
          color: Color(0xff0E9190),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        selectedIconTheme: IconThemeData(color: Color(0xff0E9190), size: 24),
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.shade400,
          size: 20,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade600,
          fontSize: 11,
        ),
        elevation: 10,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ));
  static ThemeData darkMode = ThemeData();
}

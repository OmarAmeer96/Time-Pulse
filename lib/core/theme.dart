import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color.fromARGB(255, 14, 145, 145);
  static Color redColor = Color(0xffF54140);
  static Color blackColor = Color.fromARGB(255, 56, 53, 53);
  static Color greyColor = Color(0xff575656);

  static ThemeData lightMode = ThemeData(
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
      ),
      colorScheme: ColorScheme.light(primary: primaryColor, error: redColor),
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      canvasColor: Colors.white,
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

  static ThemeData darkMode = ThemeData(
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
      ),
      datePickerTheme: DatePickerThemeData(backgroundColor: blackColor),
      colorScheme: ColorScheme.dark(primary: primaryColor),
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      scaffoldBackgroundColor: blackColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: blackColor,
        backgroundColor: Color(0xff0E9190),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: greyColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff0E9190),
        selectedLabelStyle: TextStyle(
          color: Color(0xff0E9190),
          fontSize: 15,
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
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ));
}

import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);
  static const Color lightGrey = Color(0xFFC8C9CB);
  static const Color lightDark = Color(0xFF141922);

  static final ThemeData light = ThemeData(
      bottomAppBarColor: Colors.white,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: lightPrimary, size: 36),
          unselectedIconTheme: IconThemeData(color: lightGrey, size: 36)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18)))),
      textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )));

  static final ThemeData dark = ThemeData(
    bottomAppBarColor: lightDark ,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: darkScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: lightPrimary, size: 36),
          unselectedIconTheme: IconThemeData(color: lightGrey, size: 36)),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkScaffoldBackground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18)))),
      textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )));
}

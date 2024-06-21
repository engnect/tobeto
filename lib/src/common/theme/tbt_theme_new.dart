import 'package:flutter/material.dart';

class TBTColosScheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.black,
    // brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromRGBO(235, 235, 235, 1),
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: const Color.fromARGB(250, 24, 24, 24),
          onPrimary: const Color.fromARGB(255, 79, 75, 104),
          secondary: const Color.fromRGBO(110, 110, 110, 1),
          onSecondary: const Color.fromRGBO(130, 130, 130, 1),
          background: Colors.white,
        ),
    iconTheme: const IconThemeData(color: Colors.black),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(225, 225, 225, 1),
    ),
    appBarTheme: const AppBarTheme(color: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    // brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromRGBO(40, 40, 40, 1),
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: Colors.white,
          onPrimary: const Color.fromARGB(255, 129, 125, 161),
          secondary: const Color.fromRGBO(160, 160, 160, 1),
          onSecondary: const Color.fromRGBO(180, 180, 180, 1),
          background: const Color.fromARGB(255, 20, 20, 20),
        ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
    ),
    appBarTheme: const AppBarTheme(color: Color.fromRGBO(25, 25, 25, 1)),
  );
}

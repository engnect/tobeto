import 'package:flutter/material.dart';

class TBTPalette {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromRGBO(153, 51, 255, 1.00),
    scaffoldBackgroundColor: Colors.amber,
    navigationBarTheme: const NavigationBarThemeData(
      //NAVİGASYON BARI TEMA
      backgroundColor: Colors.purple,
      indicatorColor: Colors.amber,
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(color: Colors.brown, size: 40),
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.red,
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 40,
      centerTitle: true,
      //titleTextStyle: TextStyle(color: lightTheme.primaryColor),
    ),
    // typography: Typography(), //YAZI TİPİ VS
    cardTheme: const CardTheme(
      //CARD TEMASI
      color: Colors.blue,
      shadowColor: Colors.black,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    ),
    cardColor: Colors.green,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromARGB(255, 46, 39, 53),
    scaffoldBackgroundColor: const Color.fromARGB(255, 58, 54, 62),
    navigationBarTheme: const NavigationBarThemeData(
      //NAVİGASYON BARI TEMA
      backgroundColor: Color.fromARGB(255, 119, 31, 135),
      indicatorColor: Color.fromARGB(255, 181, 23, 205),
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(color: Colors.brown, size: 40),
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Color.fromARGB(255, 163, 28, 141),
      backgroundColor: Color.fromARGB(255, 46, 39, 53),
      shadowColor: Color.fromARGB(255, 81, 79, 81),
      elevation: 20,
      centerTitle: true,
      // titleTextStyle: TextStyle(color: lightTheme.primaryColor),
    ),
    // typography: Typography(), //YAZI TİPİ VS
    cardTheme: const CardTheme(
      //CARD TEMASI
      color: Color.fromARGB(255, 192, 27, 192),
      shadowColor: Color.fromARGB(255, 167, 165, 167),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    ),
    cardColor: const Color.fromARGB(255, 221, 221, 221),
  );
}

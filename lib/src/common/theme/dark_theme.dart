import 'package:flutter/material.dart';

final darkTheme = ThemeData(
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
  textTheme: const TextTheme(
    // TEXT THEME
    bodyMedium: TextStyle(
        color: Colors.grey,
        fontFamily: AutofillHints.postalAddressExtendedPostalCode,
        fontSize: 35,
        fontStyle: FontStyle.normal),
    displayMedium: TextStyle(
      color: Colors.orange,
      fontSize: 40,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      color: Colors.yellow,
      fontSize: 60,
      fontStyle: FontStyle.italic,
    ),
  ),
);

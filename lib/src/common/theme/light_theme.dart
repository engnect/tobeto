import 'package:flutter/material.dart';

final lightTheme = ThemeData(
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
  textTheme: const TextTheme(
    // TEXT THEME
    bodyMedium: TextStyle(
        color: Colors.grey,
        fontFamily: AutofillHints.postalAddressExtendedPostalCode,
        fontSize: 35,
        fontStyle: FontStyle.normal),
    displayMedium: TextStyle(
      color: Colors.orange,
      fontFamily: String.fromEnvironment(AutofillHints.creditCardNumber),
      fontSize: 40,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      color: Colors.yellow,
      fontFamily: AutofillHints.addressState,
      fontSize: 60,
      fontStyle: FontStyle.italic,
    ),
  ),
);

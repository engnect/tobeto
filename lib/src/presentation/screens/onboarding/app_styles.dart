import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AppStyles {
  static const Color primaryColor = Color.fromARGB(255, 153, 51, 255);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 28,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 20,
    color: primaryColor,
  );

  static const PageDecoration pageDecoration = PageDecoration(
    pageColor: Colors.white,
    bodyTextStyle: bodyTextStyle,
    imagePadding: EdgeInsets.only(top: 120),
    titlePadding: EdgeInsets.only(top: 60),
    titleTextStyle: titleTextStyle,
  );
}

import 'package:flutter/material.dart';

class TBTPalette {
  static ThemeData lightTheme = ThemeData.light().copyWith(
//ANA RENKLER
    colorScheme: const ColorScheme.light().copyWith(
        primary: const Color.fromARGB(255, 153, 51, 255),
        secondary: Colors.deepPurple),
    primaryColor: const Color.fromARGB(
        255, 153, 51, 255), //Onlar Üstteki primaryle aynı yapmışlar.
    scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),

//NAVİGASYON BARI TEMA
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 30, 19, 33),
      indicatorColor: Colors.amber,

//İKON TEMA
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(
          color: Color.fromARGB(255, 153, 51, 255),
        ),
      ),
    ),

    //   elevatedButtonTheme: , ------ vardı gördüm
    // listTileTheme: ,
    // tabBarTheme: ,

//APPBAR TEMA
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20), //Onlar vermiş vermeyebiliriz
        actionsIconTheme: IconThemeData(
            color: Color.fromARGB(255, 153, 51, 255)), //END DRAWER DEĞİŞTİ
        foregroundColor: Color.fromARGB(255, 153, 51, 255),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 30,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Color.fromARGB(255, 153, 51, 255)) //DRAWER DEĞİŞTİ
        //titleTextStyle: TextStyle(color: lightTheme.primaryColor),
        ),

//CARD TEMA
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 221, 221, 221),
      shadowColor: Colors.black,
      elevation: 30,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

//TEXT TEMA
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
      bodySmall: TextStyle(fontSize: 16, color: Colors.black),
      displayLarge: TextStyle(
          fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
      displaySmall: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      headlineLarge: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      headlineSmall: TextStyle(
          fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
      labelLarge: TextStyle(fontSize: 14, color: Colors.black),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
      titleSmall: TextStyle(fontSize: 21, color: Colors.black),
    ),

//DRAWER TEMA

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
    ),
  );

//DARK TEMA

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple,
        secondary: Color.fromARGB(255, 153, 51, 255)),
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color.fromARGB(255, 58, 54, 62),

    // bottomNavigationBarTheme:
    //   const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),

//NAVİGASYON BARI TEMA
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 119, 31, 135),
      indicatorColor: Color.fromARGB(255, 181, 23, 205),

//İKON TEMA---- ETKİ ETMEDİ HAZIRI YA DA TEMADAN GELEN İYİ
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(color: Colors.brown, size: 40),
      ),
    ),

//APPBAR TEMA
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20), //Onlar vermiş vermeyebiliriz
        actionsIconTheme: IconThemeData(
            color: Color.fromARGB(255, 161, 157, 164)), //END DRAWER DEĞİŞTİ
        foregroundColor: Color.fromARGB(255, 252, 246, 251),
        backgroundColor: Color.fromARGB(137, 48, 46, 46), //ONLARDAN ALDIM
        shadowColor: Color.fromARGB(255, 81, 79, 81),
        elevation: 20,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Color.fromARGB(255, 174, 125, 211)) //DRAWER DEĞİŞTİ
        ),

//CARD TEMA
    cardTheme: CardTheme(
      //CARD TEMASI
      color: const Color.fromARGB(255, 129, 127, 129),
      shadowColor: const Color.fromARGB(255, 200, 195, 200),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

//TEXT TEMA

    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
      bodySmall: TextStyle(fontSize: 16, color: Colors.white),
      displayLarge: TextStyle(
          fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
      labelLarge: TextStyle(fontSize: 14, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
      titleSmall: TextStyle(fontSize: 21, color: Colors.white),
    ),

//DRAWER TEMA

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 58, 54, 62),
    ),
  );
}

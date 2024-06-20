import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TBTPalette {
  static ThemeData lightTheme = ThemeData.light().copyWith(
//ANA RENKLER
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color.fromARGB(255, 153, 51, 255),
      secondary: Colors.deepPurple,
      background: Colors.white,
      onPrimary: Colors.amber,
    ),

    primaryColor: const Color.fromARGB(255, 153, 51, 255),
    canvasColor: Colors.purple,
    //VİDEO PLAY SEMBOLÜ
    cardColor: Colors.grey,
    scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),

//NAVİGASYON BARI TEMA
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      indicatorColor: Color.fromARGB(255, 235, 235, 235),

//İKON TEMA
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(
          color: Colors.black,
        ),
      ),
    ),

//APPBAR TEMA  ---- AYARLI HER AYARI
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 42, 42, 42),
        fontSize: 20,
      ), //Onlar vermiş vermeyebiliriz
      actionsIconTheme: IconThemeData(
        color: Color.fromARGB(255, 153, 51, 255),
      ), //END DRAWER DEĞİŞTİ
      foregroundColor: Color.fromARGB(255, 153, 51, 255),
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 30,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 153, 51, 255),
      ), //DRAWER DEĞİŞTİ
      //titleTextStyle: TextStyle(color: lightTheme.primaryColor),
    ),

//CARD TEMA
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 255, 255, 255),
      shadowColor: Colors.black,
      elevation: 30,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ),

//TEXT TEMA
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        //ADRESTE KULLANDIM
        textStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        //HOCA İSİMLERİNİN ALTINDA KULLANDIM.
        textStyle: const TextStyle(
          fontSize: 19,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      displayLarge: GoogleFonts.poppins(
        //EKİBİMİZ YAZISINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      displayMedium: GoogleFonts.poppins(
        //OFİSİMİZ BAŞLIĞI-TOBETO FARKI NEDİR
        textStyle: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      displaySmall: GoogleFonts.poppins(
        // EKİBİMİZ HOCA BAŞLIĞINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      headlineLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      headlineMedium: GoogleFonts.poppins(
        //TOBETO FARKI NEDİRİN ALTINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      headlineSmall: GoogleFonts.poppins(
        //SAYFADAKİ GENEL YAZILARDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      labelLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      labelMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      labelSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 10,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      titleLarge: GoogleFonts.poppins(
        //MOR RENK İÇİN KULLANDIM
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 153, 51, 255),
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        //iletisim bilgileri sol taraf
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 42, 42, 42),
        ),
      ),
    ),

//DRAWER TEMA

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
    ),
  );

//DARK TEMA

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorLight: const Color.fromARGB(255, 153, 51, 255),
    canvasColor: Colors.purple, //VİDEO PLAY SEMBOLÜ
    cardColor: Colors.grey, //VİDEONUN NE KADARI İZLENDİ
    colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 126, 97, 175), //switch rengi ve isim
        secondary: Colors.deepPurple,
        onPrimary: Colors.blue,
        background: Colors.black),
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color.fromARGB(255, 45, 43, 46),

    // bottomNavigationBarTheme:
    //   const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),

//NAVİGASYON BARI TEMA
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 45, 43, 46),
      indicatorColor: Color.fromARGB(255, 235, 235, 235),

//İKON TEMA---- ETKİ ETMEDİ HAZIRI YA DA TEMADAN GELEN İYİ
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(
          color: Colors.red,
        ),
      ),
    ),

//APPBAR TEMA
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20), //Onlar vermiş vermeyebiliriz
      actionsIconTheme: IconThemeData(
        color: Color.fromARGB(255, 161, 157, 164),
      ), //END DRAWER DEĞİŞTİ
      foregroundColor: Color.fromARGB(255, 252, 246, 251),
      backgroundColor: Color.fromARGB(
          255, 58, 54, 62), //Color.fromARGB(255, 79, 28, 118), //ONLARDAN ALDIM
      shadowColor: Color.fromARGB(255, 81, 79, 81),
      elevation: 20,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 161, 157, 164),
      ), //DRAWER DEĞİŞTİ
    ),

//CARD TEMA
    cardTheme: const CardTheme(
      //CARD TEMASI
      color: Color.fromARGB(255, 200, 191, 191), //EKİBİMİZİN ARKAPLANI
      shadowColor: Color.fromARGB(255, 153, 51, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
    ),

//TEXT TEMA

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        //ADRESTE KULLANDIM
        textStyle: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        //HOCA İSİMLERİNİN ALTINDA KULLANDIM.
        textStyle: const TextStyle(
          fontSize: 19,
          color: Colors.white,
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      displayLarge: GoogleFonts.poppins(
        //EKİBİMİZ YAZISINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      displayMedium: GoogleFonts.poppins(
        //OFİSİMİZ BAŞLIĞI-TOBETO FARKI NEDİR
        textStyle: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      displaySmall: GoogleFonts.poppins(
        // EKİBİMİZ HOCA BAŞLIĞINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      headlineLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      headlineMedium: GoogleFonts.poppins(
        //TOBETO FARKI NEDİRİN ALTINDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      headlineSmall: GoogleFonts.poppins(
        //SAYFADAKİ GENEL YAZILARDA KULLANDIM
        textStyle: const TextStyle(
          fontSize: 17,
          //fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      labelLarge: GoogleFonts.poppins(
        //BOŞTA
        textStyle: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      labelMedium: GoogleFonts.poppins(
        //TAKVİM TARAFINDA
        textStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      labelSmall: GoogleFonts.poppins(
        //BOŞTA DAHA KULLANMADIM
        textStyle: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
      titleLarge: GoogleFonts.poppins(
        //MOR RENK İÇİN KULLANDIM
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 153, 51, 255),
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        //Takvimde etkinlik yazısında
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

//DRAWER TEMA

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 45, 43, 46),
    ),
  );
}

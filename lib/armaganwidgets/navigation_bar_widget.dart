import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/screens/home_page/home_page.dart';


class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int index = 2;

  // final screens = [
  //   const ProfilPage(),
  //   const LoginPage(),
  //   const RegisterPage(),    ==>> Sayfalar tamamlalanınca aktif olacak!
  //   const LessonsPage(),
  //   const Homepage(),
  // ];

  final items = <Widget>[
    const Icon(Icons.home, size: 30),
    const Icon(Icons.menu_book, size: 30),
    const Icon(Icons.play_lesson, size: 30),
    const Icon(Icons.calendar_month_outlined, size: 30),
    const Icon(Icons.person, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const Homepage(), //  bu kısım Sayfalar tamamlanınca değişecek
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 235, 235, 235), //icon rengi değişimi
          ),
        ),
        child: CurvedNavigationBar(
          backgroundColor: const Color.fromARGB(20, 153, 51, 255),
          buttonBackgroundColor: const Color.fromARGB(255, 99, 21, 177),
          height: 47,
          items: items,
          index: index,
          onTap: (index) => setState(() => this.index = index),
          color: const Color.fromARGB(255, 153, 51, 255),
        ),
      ),
    );
  }
}

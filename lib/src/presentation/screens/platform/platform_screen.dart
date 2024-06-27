import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../export_screens.dart';

class PlatformScreen extends StatefulWidget {
  const PlatformScreen({super.key});

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  int index = 0;

  final screens = [
    const PlatformTabScreen(),
    const ApplicationsTabScreen(),
    const CourseTabScreen(),
    const ProfileDetailsTabScreen(),
  ];

  final items = <Widget>[
    const Icon(Icons.home, size: 30),
    const Icon(Icons.menu_book, size: 30),
    const Icon(Icons.play_lesson, size: 30),
    const Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 235, 235, 235),
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
      ),
    );
  }
}

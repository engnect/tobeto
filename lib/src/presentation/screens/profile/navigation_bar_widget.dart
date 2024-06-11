import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/blog/blog_screen.dart';
import 'package:tobeto/src/presentation/screens/calendar/calendar_screen.dart';
import 'package:tobeto/src/presentation/screens/course/course_screen.dart';
import 'package:tobeto/src/presentation/screens/platform/tabs/platform_tab.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_screen.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int indx = 0;

  final screens = [
    const PlatformTab(),
    const BlogScreen(),
    const CourseScreen(),
    const CalendarScreen(),
    const ProfileScreen()
  ];

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
      body: screens[indx],
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
          index: indx,
          onTap: (index) => setState(() => indx = index),
          color: const Color.fromARGB(255, 153, 51, 255),
        ),
      ),
    );
  }
}

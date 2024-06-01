import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:tobeto/armaganwidgets/profil_page.dart';
import 'package:tobeto/firebase_options.dart';
import 'package:tobeto/screens/about_us_page/about_us_page.dart';
import 'package:tobeto/screens/communication_page/communication_page.dart';

import 'package:tobeto/screens/course_page/course_page.dart';

import 'package:tobeto/screens/in_the_press/in_the_press_page.dart';
import 'package:tobeto/screens/in_the_press/widgets/in_the_press_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CoursePage(),
      ),
    );
  }
}

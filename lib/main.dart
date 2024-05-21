import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/armaganwidgets/profil_page.dart';
import 'package:tobeto/firebase_options.dart';
import 'package:tobeto/screens/home_page/extract_home_page.dart';
import 'package:tobeto/screens/main_home_page/main_home_page.dart';


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
        body: MainHomePage(),
      ),
    );
  }
}

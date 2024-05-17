import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/screens/login_page.dart';
import 'package:tobeto/widgets/navigation_bar_widget.dart';
import 'package:tobeto/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;

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
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Hello World!',
              style: TextStyle(fontSize: 31),
            ),
          ),
        ),
      ),
    );
  }
}

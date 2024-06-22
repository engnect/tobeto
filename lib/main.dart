import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobeto/app_view.dart';
import 'package:tobeto/firebase_options.dart';
import 'package:tobeto/simple_bloc_observer.dart';
import 'package:tobeto/src/common/theme/tbt_theme.dart';
import 'package:tobeto/src/data/datasource/theme_shared_pref.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final ThemePreferences pref = ThemePreferences();
  final isDarkTheme = await pref.getTheme();
  final initialTheme =
      isDarkTheme ? TBTPalette.darkTheme : TBTPalette.lightTheme;
  initScreen = preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 1);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();

  runApp(const MainApp());
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobeto/firebase_options.dart';
import 'package:tobeto/simple_bloc_observer.dart';
import 'package:tobeto/src/presentation/screens/home/home_screen.dart';
import 'package:tobeto/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tobeto/src/presentation/screens/platform/platform_screen.dart';
import 'src/common/router/app_router.dart';
// import 'src/lang/lang.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 1);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: CourseScreen(),
      // ),
      // locale: Locale('tr'),
      // supportedLocales: [
      //   Locale('en', ''),
      //   Locale('tr', ''),
      // ],
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      onGenerateRoute: AppRouter().generateRoute,
      // initialRoute: initScreen == 0 || initScreen == null
      //     ? AppRouteNames.onboardingRoute
      //     : AppRouteNames.platformScreenRoute,
      initialRoute: AppRouteNames.homeRoute,

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const PlatformScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
      // home: PlatformScreen(),
    );
  }
}

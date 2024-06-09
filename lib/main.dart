import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobeto/firebase_options.dart';
import 'package:tobeto/src/presentation/screens/home/home_screen.dart';
import 'package:tobeto/src/presentation/screens/onboarding/onboarding_screen.dart';
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
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: initScreen == 0 || initScreen == null
          ? AppRouteNames.onboardingRoute
          : AppRouteNames.platformScreenRoute,
      // home: PlatformScreen(),
    );
  }
}

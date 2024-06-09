import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/firebase_options.dart';

import 'src/common/router/app_router.dart';
// import 'src/lang/lang.dart';

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
      initialRoute: AppRouteNames.profileScreenRoute,
    );
  }
}

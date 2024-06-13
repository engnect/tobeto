import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null
            ? AppRouteNames.platformScreenRoute
            : AppRouteNames.homeRoute,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        onGenerateRoute: AppRouter().generateRoute,
        // initialRoute: initScreen == 0 || initScreen == null
        //     ? AppRouteNames.onboardingRoute
        //     : AppRouteNames.platformScreenRoute,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? AppRouteNames.homeRoute
            : AppRouteNames.platformScreenRoute,
        // home: NavigationBarWidget(),
      ),
    );
  }
}

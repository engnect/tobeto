import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/blocs/export_blocs.dart';
import 'src/common/export_common.dart';
import 'src/domain/export_domain.dart';

class AppView extends StatefulWidget {
  final ThemeData themeData;
  const AppView({
    super.key,
    required this.themeData,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.authStateChanges().listen((event) {
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
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              navigatorKey: _navigatorKey,
              onGenerateRoute: AppRouter().generateRoute,
              // initialRoute: initScreen == 0 || initScreen == null
              //     ? AppRouteNames.onboardingRoute
              //     : AppRouteNames.platformScreenRoute,
              initialRoute: FirebaseAuth.instance.currentUser == null
                  ? AppRouteNames.homeRoute
                  : AppRouteNames.platformScreenRoute,
            );
          },
        );
      },
    );
  }
}

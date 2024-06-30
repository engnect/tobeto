import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tobeto/app_view.dart';
import 'package:tobeto/src/blocs/export_blocs.dart';
import 'package:tobeto/src/domain/export_domain.dart';

class App extends StatelessWidget {
  final ThemeData initialThemeData;

  const App({
    super.key,
    required this.initialThemeData,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(
            ThemeState(
              themeData: initialThemeData,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: UserRepository(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: AppView(
        themeData: initialThemeData,
      ),
    );
  }
}

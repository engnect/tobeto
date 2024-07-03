import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/app_view.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/domain/export_domain.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: UserRepository(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

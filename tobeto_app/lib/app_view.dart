import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'src/common/export_common.dart';

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class _AppViewState extends State<AppView> {
  bool _initialAuthCheckPerformed = false;

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.watch<LanguageCubit>().state;
    final onboardingState = context.watch<OnboardingCubit>().state;
    final themeCubit = context.watch<ThemeCubit>().state;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is Authenticated) {
          if (!_initialAuthCheckPerformed) {
            _initialAuthCheckPerformed = true;
            _navigatorKey.currentState!
                .pushReplacementNamed(AppRouteNames.platformScreenRoute);
          }
        } else if (authState is Unauthenticated) {
          _initialAuthCheckPerformed = false;
          final navigator = _navigatorKey.currentState;
          if (navigator != null) {
            navigator.pushReplacementNamed(AppRouteNames.homeRoute);
          }
        }
      },
      child: ToastificationWrapper(
        child: MaterialApp(
          navigatorKey: !onboardingState ? null : _navigatorKey,
          locale: languageCubit,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme:
              themeCubit ? TBTColorScheme.darkTheme : TBTColorScheme.lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: !onboardingState
              ? AppRouteNames.onboardingRoute
              : AppRouteNames.homeRoute,
        ),
      ),
    );
  }
}

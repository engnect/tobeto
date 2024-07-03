import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  @override
  Widget build(BuildContext context) {
    final languageCubit = context.watch<LanguageCubit>().state;
    final onboardingState = context.watch<OnboardingCubit>().state;
    final themeCubit = context.watch<ThemeCubit>().state;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _navigatorKey.currentState?.pushReplacementNamed(
            AppRouteNames.platformScreenRoute,
          );
        } else if (state is Unauthenticated) {
          _navigatorKey.currentState?.pushReplacementNamed(
            AppRouteNames.homeRoute,
          );
        }
      },
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
    );
  }
}

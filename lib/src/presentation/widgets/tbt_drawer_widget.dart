import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/blocs/language/language_cubit.dart';
import 'package:tobeto/src/blocs/theme/theme_bloc.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/common/theme/tbt_theme.dart';
import 'package:tobeto/src/data/datasource/theme_shared_pref.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';
import '../../common/constants/assets.dart';

class TBTDrawer extends StatefulWidget {
  const TBTDrawer({
    super.key,
  });

  @override
  State<TBTDrawer> createState() => _TBTDrawerState();
}

class _TBTDrawerState extends State<TBTDrawer> {
  final prefs = ThemePreferences();
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.70,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          children: [
            SizedBox(
              height: 75,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        Assets.imagesTobetoLogo,
                        width: 150,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.homeRoute);
                      },
                    ),
                    GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                context.translate.who_we_are,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRouteNames.aboutUsScreenRoute);
              },
            ),
            CustomExpansionTile(
              title: Text(
                context.translate.what_we_offer,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary),
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                    title: TBTPurpleButton(
                      buttonText: context.translate.for_individuals,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.forIndividualsScreenRoute);
                      },
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                  title: TBTPurpleButton(
                    buttonText: context.translate.for_companies,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouteNames.forCompaniesScreenRoute);
                    },
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                context.translate.our_trainings,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {},
            ),
            CustomExpansionTile(
              title: Text(
                context.translate.whats_happening_at_tobeto,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary),
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: context.translate.blog,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.blogScreenRoute);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: context.translate.in_the_press,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.inThePressScreenRoute);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      title: TBTPurpleButton(
                        buttonText: context.translate.calendar,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRouteNames.calendarScreenRoute);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                context.translate.contact_us,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRouteNames.contactUsScreenRoute);
              },
            ),

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial || state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Authenticated) {
                  return CustomExpansionTile(
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(state.userModel.userAvatarUrl!),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                '${state.userModel.userName} ${state.userModel.userSurname}',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            title: TBTPurpleButton(
                              buttonText: "Platform",
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AppRouteNames.platformScreenRoute);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: ListTile(
                            onTap: () {},
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            title: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () async {
                                AuthRepository().signOutUser();
                              },
                              child: const Text(
                                "Çıkış Yap",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                } else if (state is Unauthenticated) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            AppRouteNames.auhtScreenRoute);
                      },
                      child: const Text(
                        "Giriş yap",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('Hata!');
                }
              },
            ),

            // theme switch
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDarkTheme =
                    state.themeData.brightness == Brightness.dark;

                return Switch(
                  value: isDarkTheme,
                  onChanged: (value) async {
                    final newTheme = value
                        ? TBTColorScheme.darkTheme
                        : TBTColorScheme.lightTheme;

                    context.read<ThemeBloc>().add(
                          ThemeChanged(themeData: newTheme),
                        );

                    await prefs.saveTheme(value);
                  },
                );
              },
            ),

            // language changer switch
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, state) {
                int languageValue = context.read<LanguageCubit>().languageValue;
                return AnimatedToggleSwitch.rolling(
                  indicatorTransition:
                      const ForegroundIndicatorTransition.rolling(),
                  spacing: 10,
                  style: const ToggleStyle(
                    backgroundColor: Colors.white,
                    indicatorColor: Colors.black,
                  ),
                  height: 50,
                  borderWidth: 0,
                  current: languageValue,
                  values: const [0, 1, 2],
                  onChanged: (i) {
                    Locale newLocale;
                    if (i == 0) {
                      newLocale = const Locale('en', 'UK');
                    } else if (i == 1) {
                      newLocale = const Locale('tr', 'TR');
                    } else {
                      newLocale = const Locale('de', 'DE');
                    }
                    context.read<LanguageCubit>().changeLanguage(newLocale, i);
                  },
                  iconList: [
                    CountryFlag.fromLanguageCode('en', shape: const Circle()),
                    CountryFlag.fromLanguageCode('tr', shape: const Circle()),
                    CountryFlag.fromLanguageCode('de', shape: const Circle()),
                  ],
                );
              },
            ),
            // copyright
            Text(
              '© ${DateFormat('yyyy').format(DateTime.now())} Tobeto',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  final Widget title;
  final List<Widget> children;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: widget.title,
          // trailing: Icon(
          //   _isExpanded ? Icons.expand_less : Icons.expand_more,
          // ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(
            children: widget.children,
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 350),
        ),
      ],
    );
  }
}


// TextButton.icon(
//                     onLongPress: () {
//                       print("uzunnn basıldıı");
//                     },
//                     onPressed: () {
//                       Navigator.of(context)
//                           .pushNamed(AppRouteNames.platformScreenRoute);
//                     },
//                     icon: CircleAvatar(
//                       backgroundImage:
//                           NetworkImage(state.userModel.userAvatarUrl!),
//                     ),
//                     label: Text(
//                         '${state.userModel.userName} ${state.userModel.userSurname}'),
//                   );
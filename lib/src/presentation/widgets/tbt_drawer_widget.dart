import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/presentation/widgets/export_widgets.dart';
import '../../common/export_common.dart';
import '../../domain/repositories/auth_repository.dart';

class TBTDrawer extends StatefulWidget {
  const TBTDrawer({
    super.key,
  });

  @override
  State<TBTDrawer> createState() => _TBTDrawerState();
}

class _TBTDrawerState extends State<TBTDrawer> with TickerProviderStateMixin {
  late final AnimationController _themeSwitchController;
  @override
  void initState() {
    super.initState();

    _themeSwitchController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
  }

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
                            .pushNamed(AppRouteNames.homeRoute)
                            .then(
                          (_) {
                            Navigator.of(context).pop();
                          },
                        );
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
                    .pushNamed(AppRouteNames.aboutUsScreenRoute)
                    .then(
                  (_) {
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            DrawerExpansionTile(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: context.translate.for_individuals,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.forIndividualsScreenRoute)
                            .then(
                          (_) {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: TBTPurpleButton(
                    buttonText: context.translate.for_companies,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouteNames.forCompaniesScreenRoute)
                          .then(
                        (_) {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            DrawerExpansionTile(
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
                            .pushNamed(AppRouteNames.blogScreenRoute)
                            .then(
                          (_) {
                            Navigator.of(context).pop();
                          },
                        );
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
                            .pushNamed(AppRouteNames.inThePressScreenRoute)
                            .then(
                          (_) {
                            Navigator.of(context).pop();
                          },
                        );
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
                              .pushNamed(AppRouteNames.calendarScreenRoute)
                              .then(
                            (_) {
                              Navigator.of(context).pop();
                            },
                          );
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
                    .pushNamed(AppRouteNames.contactUsScreenRoute)
                    .then(
                  (_) {
                    Navigator.of(context).pop();
                  },
                );
              },
            ),

            // login - platform
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial || state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Authenticated) {
                  return DrawerExpansionTile(
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
                                Navigator.of(context)
                                    .pushNamed(
                                        AppRouteNames.platformScreenRoute)
                                    .then((_) => Navigator.of(context).pop());
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
                              child: Text(
                                context.translate.logout,
                                style: const TextStyle(
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
                      child: Text(
                        context.translate.login,
                        style: const TextStyle(
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
            BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return Switch(
                  value: state,
                  onChanged: (value) {
                    // context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),

            // yeni tema swich
            BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (state != false) {
                      _themeSwitchController.reverse();
                      context.read<ThemeCubit>().toggleTheme();
                    } else {
                      _themeSwitchController.forward();
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        _themeSwitchController.stop();
                      });
                      context.read<ThemeCubit>().toggleTheme();
                    }
                  },
                  child: LottieBuilder.asset(
                    height: 50,
                    fit: BoxFit.contain,
                    Assets.animationThemeSwitch,
                    controller: _themeSwitchController,
                    onLoaded: (comp) {
                      _themeSwitchController.duration = comp.duration;
                    },
                  ),
                );
              },
            ),
            // language changer switch
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, state) {
                int languageValue = context.read<LanguageCubit>().languageValue;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: AnimatedToggleSwitch.rolling(
                    animationDuration: const Duration(milliseconds: 1500),
                    indicatorTransition:
                        const ForegroundIndicatorTransition.rolling(),
                    spacing: 10,
                    style: ToggleStyle(
                      backgroundColor: Colors.transparent,
                      indicatorColor: Theme.of(context).colorScheme.primary,
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
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(newLocale, i);
                    },
                    iconList: [
                      CountryFlag.fromLanguageCode('en', shape: const Circle()),
                      CountryFlag.fromLanguageCode('tr', shape: const Circle()),
                      CountryFlag.fromLanguageCode('de', shape: const Circle()),
                    ],
                  ),
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
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }
}

class DrawerExpansionTile extends StatefulWidget {
  const DrawerExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  final Widget title;
  final List<Widget> children;

  @override
  State<DrawerExpansionTile> createState() => _DrawerExpansionTileState();
}

class _DrawerExpansionTileState extends State<DrawerExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: widget.title,
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

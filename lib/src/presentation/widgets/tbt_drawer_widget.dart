import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/presentation/widgets/export_widgets.dart';
import '../../common/export_common.dart';
import '../../domain/repositories/auth_repository.dart';

class TBTDrawer extends StatefulWidget {
  const TBTDrawer({super.key});

  @override
  State<TBTDrawer> createState() => _TBTDrawerState();
}

class _TBTDrawerState extends State<TBTDrawer> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.70,
      child: Drawer(
        child: ListView(
          children: [
            _buildDrawerHeader(context),
            _buildListTile(
              context,
              title: context.translate.who_we_are,
              routeName: AppRouteNames.aboutUsScreenRoute,
            ),
            _buildExpansionTile(
              context,
              title: context.translate.what_we_offer,
              children: [
                _buildButtonTile(
                  context,
                  text: context.translate.for_individuals,
                  routeName: AppRouteNames.forIndividualsScreenRoute,
                ),
                _buildButtonTile(
                  context,
                  text: context.translate.for_companies,
                  routeName: AppRouteNames.forCompaniesScreenRoute,
                ),
              ],
            ),
            _buildExpansionTile(
              context,
              title: context.translate.whats_happening_at_tobeto,
              children: [
                _buildButtonTile(
                  context,
                  text: context.translate.blog,
                  arguments: true,
                  routeName: AppRouteNames.blogScreenRoute,
                ),
                _buildButtonTile(
                  context,
                  text: context.translate.in_the_press,
                  arguments: false,
                  routeName: AppRouteNames.blogScreenRoute,
                ),
                _buildButtonTile(
                  context,
                  text: context.translate.calendar,
                  routeName: AppRouteNames.calendarScreenRoute,
                ),
              ],
            ),
            _buildListTile(
              context,
              title: context.translate.contact_us,
              routeName: AppRouteNames.contactUsScreenRoute,
            ),
            _buildAuthSection(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.13),
            _buildThemeSwitch(context),
            _buildLanguageSwitch(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: 75,
      child: DrawerHeader(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Image.asset(Assets.imagesTobetoLogo, width: 150),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRouteNames.homeRoute);
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonTile(
    BuildContext context, {
    required String text,
    required String routeName,
    Object? arguments,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: TBTPurpleButton(
        buttonText: text,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(routeName, arguments: arguments);
        },
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required String routeName,
    Object? arguments,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(routeName, arguments: arguments);
      },
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String title, required List<Widget> children}) {
    return DrawerExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      children: children,
    );
  }

  Widget _buildAuthSection(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Authenticated) {
          return DrawerExpansionTile(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(state.userModel.userAvatarUrl!),
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
              _buildButtonTile(
                context,
                text: "Platform",
                routeName: AppRouteNames.platformScreenRoute,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                title: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () async => AuthRepository().signOutUser(),
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
            ],
          );
        } else if (state is Unauthenticated) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRouteNames.auhtScreenRoute);
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
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: AnimatedToggleSwitch<bool>.dual(
            current: state,
            first: false,
            second: true,
            spacing: 10.0,
            animationDuration: const Duration(milliseconds: 600),
            style: const ToggleStyle(
              indicatorColor: Colors.white,
              borderColor: Colors.transparent,
              backgroundGradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.deepPurple,
                  Colors.pinkAccent,
                  Colors.orangeAccent,
                ],
              ),
            ),
            borderWidth: 3.0,
            height: 50,
            onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
            iconBuilder: (value) => value
                ? const Icon(Icons.circle)
                : const Icon(Icons.circle_rounded),
            textBuilder: (value) => value
                ? const Center(child: Icon(Icons.dark_mode_outlined, size: 40))
                : const Center(child: Icon(Icons.wb_sunny_outlined, size: 40)),
          ),
        );
      },
    );
  }

  Widget _buildLanguageSwitch(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        int languageValue = context.read<LanguageCubit>().languageValue;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: AnimatedToggleSwitch.rolling(
            animationDuration: const Duration(milliseconds: 1500),
            indicatorTransition: const ForegroundIndicatorTransition.rolling(),
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
              context.read<LanguageCubit>().changeLanguage(newLocale, i);
            },
            iconList: [
              CountryFlag.fromLanguageCode('en', shape: const Circle()),
              CountryFlag.fromLanguageCode('tr', shape: const Circle()),
              CountryFlag.fromLanguageCode('de', shape: const Circle()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          '© ${DateFormat('yyyy').format(DateTime.now())} Tobeto',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        const SizedBox(height: kToolbarHeight),
      ],
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
          secondChild: Column(children: widget.children),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 350),
        ),
      ],
    );
  }
}

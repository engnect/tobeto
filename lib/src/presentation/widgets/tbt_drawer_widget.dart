import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/blocs/theme/theme_bloc.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/data/datasource/theme_shared_pref.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
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
      widthFactor: 0.70, // Açılan ekranın genişliğini ayarlamak için
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
              title: const Text(
                "Biz Kimiz?",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRouteNames.aboutUsScreenRoute);
              },
            ),
            CustomExpansionTile(
              title: const Text(
                "Neler Sunuyoruz?",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                    title: TBTPurpleButton(
                      buttonText: "Bireyler için",
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
                    buttonText: "Kurumlar için",
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
              title: const Text(
                "Eğitimlerimiz",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              onTap: () {},
            ),
            CustomExpansionTile(
              title: const Text(
                "Tobeto'da Neler Oluyor?",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: "Blog",
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
                      buttonText: "Basında Biz",
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
                        buttonText: "Takvim",
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: const Text(
                "İletişim",
                style: TextStyle(fontFamily: "Poppins"),
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
                  return TextButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouteNames.platformScreenRoute);
                    },
                    icon: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.userModel.userAvatarUrl!),
                    ),
                    label: Text(
                        '${state.userModel.userName} ${state.userModel.userSurname}'),
                  );
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
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.loginScreenRoute);
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
                    final newTheme =
                        value ? ThemeData.dark() : ThemeData.light();

                    context.read<ThemeBloc>().add(
                          ThemeChanged(themeData: newTheme),
                        );

                    await prefs.saveTheme(value);
                  },
                );
              },
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

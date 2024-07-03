import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';

class TBTEndDrawer extends StatelessWidget {
  const TBTEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.72,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated &&
              (state.userModel.userRank == UserRank.admin ||
                  state.userModel.userRank == UserRank.instructor)) {
            return Drawer(
              backgroundColor: Theme.of(context).colorScheme.background,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                children: [
                  SizedBox(
                    height: 70,
                    child: DrawerHeader(
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Yönetim Paneli",
                              style: TextStyle(
                                color: Color.fromRGBO(126, 35, 218, 1),
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text(
                      'Takvim',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRouteNames.adminEventScreenRoute)
                        .then(
                      (_) {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  state.userModel.userRank == UserRank.admin
                      ? ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          title: Text(
                            'Kullanıcı Başvuruları',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(
                                  AppRouteNames.adminApplicationsScreenRoute)
                              .then(
                            (_) {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  state.userModel.userRank == UserRank.admin
                      ? ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          title: Text(
                            'İletişim Formları',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(
                                  AppRouteNames.adminContactFormScreenRoute)
                              .then(
                            (_) {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text(
                      'Duyurular',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRouteNames.adminAnnouncementsScreenRoute)
                        .then(
                      (_) {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  state.userModel.userRank == UserRank.admin
                      ? EndDrawerCustomExpansionTile(
                          title: Text(
                            "Medya",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          children: [
                            SizedBox(
                              height: 50,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                title: TBTPurpleButton(
                                  buttonText: "Basında Biz",
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(AppRouteNames
                                          .adminInThePressScreenRoute)
                                      .then(
                                    (_) {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              title: TBTPurpleButton(
                                buttonText: "Blog",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(
                                          AppRouteNames.adminBlogScreenRoute)
                                      .then(
                                    (_) {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  state.userModel.userRank == UserRank.admin
                      ? EndDrawerCustomExpansionTile(
                          title: Text(
                            "Kullanıcılar",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          children: [
                            SizedBox(
                              height: 50,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                title: TBTPurpleButton(
                                  buttonText: "Yöneticiler",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(
                                      AppRouteNames.adminUserListScreenRoute,
                                      arguments: UserRank.admin.index,
                                    )
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
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                title: TBTPurpleButton(
                                  buttonText: "Öğretmenler",
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(
                                      AppRouteNames.adminUserListScreenRoute,
                                      arguments: UserRank.instructor.index,
                                    )
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
                                    buttonText: "Öğrenciler",
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(
                                        AppRouteNames.adminUserListScreenRoute,
                                        arguments: UserRank.student.index,
                                      )
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
                        )
                      : const SizedBox.shrink(),
                  // Dersler ve ders videoları ekleme
                  EndDrawerCustomExpansionTile(
                    title: Text(
                      "Dersler",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          title: TBTPurpleButton(
                            buttonText: "Ders Ekle",
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRouteNames.adminCourseScreenRoute)
                                .then(
                              (_) {
                                Navigator.of(context).pop();
                              },
                            ),
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
                              buttonText: "Ders Videosu Ekle",
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(
                                      AppRouteNames.adminCourseVideoScreenRoute)
                                  .then(
                                (_) {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kToolbarHeight),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class EndDrawerCustomExpansionTile extends StatefulWidget {
  const EndDrawerCustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  final Widget title;
  final List<Widget> children;

  @override
  State<EndDrawerCustomExpansionTile> createState() =>
      _EndDrawerCustomExpansionTileState();
}

class _EndDrawerCustomExpansionTileState
    extends State<EndDrawerCustomExpansionTile> {
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

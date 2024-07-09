import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';

class TBTEndDrawer extends StatelessWidget {
  const TBTEndDrawer({super.key});

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
                  _buildDrawerHeader(context),
                  _buildListTile(
                    context,
                    title: 'Takvim',
                    routeName: AppRouteNames.adminEventScreenRoute,
                  ),
                  if (state.userModel.userRank == UserRank.admin) ...[
                    _buildListTile(
                      context,
                      title: 'Kullanıcı Başvuruları',
                      routeName: AppRouteNames.adminApplicationsScreenRoute,
                    ),
                    _buildListTile(
                      context,
                      title: 'İletişim Formları',
                      routeName: AppRouteNames.adminContactFormScreenRoute,
                    ),
                  ],
                  _buildListTile(
                    context,
                    title: 'Duyurular',
                    routeName: AppRouteNames.adminAnnouncementsScreenRoute,
                  ),
                  if (state.userModel.userRank == UserRank.admin) ...[
                    _buildExpansionTile(
                      context,
                      title: 'Medya',
                      children: [
                        _buildButtonTile(
                          context,
                          text: 'Basında Biz',
                          routeName: AppRouteNames.adminInThePressScreenRoute,
                        ),
                        _buildButtonTile(
                          context,
                          text: 'Blog',
                          routeName: AppRouteNames.adminBlogScreenRoute,
                        ),
                      ],
                    ),
                    _buildExpansionTile(
                      context,
                      title: 'Kullanıcılar',
                      children: [
                        _buildButtonTile(
                          context,
                          text: 'Yöneticiler',
                          routeName: AppRouteNames.adminUserListScreenRoute,
                          arguments: UserRank.admin.index,
                        ),
                        _buildButtonTile(
                          context,
                          text: 'Öğretmenler',
                          routeName: AppRouteNames.adminUserListScreenRoute,
                          arguments: UserRank.instructor.index,
                        ),
                        _buildButtonTile(
                          context,
                          text: 'Öğrenciler',
                          routeName: AppRouteNames.adminUserListScreenRoute,
                          arguments: UserRank.student.index,
                        ),
                      ],
                    ),
                  ],
                  _buildExpansionTile(
                    context,
                    title: 'Dersler',
                    children: [
                      _buildButtonTile(
                        context,
                        text: 'Ders Ekle',
                        routeName: AppRouteNames.adminCourseScreenRoute,
                      ),
                      _buildButtonTile(
                        context,
                        text: 'Ders Videosu Ekle',
                        routeName: AppRouteNames.adminCourseVideoScreenRoute,
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

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: 70,
      child: DrawerHeader(
        child: Row(
          children: [
            GestureDetector(
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Navigator.pop(context),
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
    );
  }

  Widget _buildListTile(BuildContext context,
      {required String title, required String routeName, Object? arguments}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(routeName, arguments: arguments)
          .then((_) => Navigator.of(context).pop()),
    );
  }

  Widget _buildButtonTile(BuildContext context,
      {required String text, required String routeName, Object? arguments}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: TBTPurpleButton(
        buttonText: text,
        onPressed: () => Navigator.of(context)
            .pushNamed(routeName, arguments: arguments)
            .then((_) => Navigator.of(context).pop()),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String title, required List<Widget> children}) {
    return EndDrawerCustomExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      children: children,
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

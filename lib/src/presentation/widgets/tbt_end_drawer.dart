import 'package:flutter/material.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/screens/admin_course/admin_course_screen.dart';
import 'package:tobeto/src/presentation/screens/admin_course/admin_course_video_screen.dart';
import 'package:tobeto/src/presentation/screens/admin_in_the_press/admin_in_the_press_screen.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';

class TBTEndDrawer extends StatelessWidget {
  const TBTEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.72,
      child: Drawer(
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
                  .pushNamed(AppRouteNames.adminEventScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                'Kullanıcı Başvuruları',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminApplicationsScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(
                'İletişim Formları',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminContactFormScreenRoute),
            ),
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
                  .pushNamed(AppRouteNames.adminAnnouncementsScreenRoute),
            ),

            CustomExpansionTile(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                    title: TBTPurpleButton(
                      buttonText: "Basında Biz",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const InThePressAdmin(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                  title: TBTPurpleButton(
                    buttonText: "Blog",
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouteNames.adminBlogScreenRoute);
                    },
                  ),
                ),
              ],
            ),
            CustomExpansionTile(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: "Yöneticiler",
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRouteNames.adminStaffScreenRoute,
                          arguments: UserRank.admin.index,
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
                      buttonText: "Öğretmenler",
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRouteNames.adminStaffScreenRoute,
                          arguments: UserRank.instructor.index,
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
                          Navigator.of(context).pushNamed(
                            AppRouteNames.adminStaffScreenRoute,
                            arguments: UserRank.student.index,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Dersler ve ders videoları ekleme
            CustomExpansionTile(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: "Ders Ekle",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AdminCourseScreen(),
                          ),
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
                        buttonText: "Ders Videosu Ekle",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AdminCourseVideoScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kToolbarHeight),
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

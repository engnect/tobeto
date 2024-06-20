import 'package:flutter/material.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/course_page/course_admin_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/course_page/course_video_admin_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/in_the_press_admin/in_the_press_admin_page.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/staff_page/staff_page.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/students_page/students_page.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class TBTEndDrawer extends StatelessWidget {
  const TBTEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.72, // Açılan ekranın genişliğini ayarlamak için
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          children: [
            SizedBox(
              height: 70,
              child: DrawerHeader(
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.close),
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
              title: const Text('Takvim'),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminEventScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: const Text('Kullanıcı Başvuruları'),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminApplicationsScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: const Text('İletişim Formları'),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminContactFormScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: const Text('Duyurular'),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRouteNames.adminAnnouncementsScreenRoute),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: const Text(
                "Kadro",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StaffPage(),
                  ),
                );
              },
            ),
            CustomExpansionTile(
              title: const Text(
                "Medya",
                style: TextStyle(fontFamily: "Poppins"),
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
              title: const Text(
                "Kullanıcılar",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: TBTPurpleButton(
                      buttonText: "Yöneticiler",
                      onPressed: () {},
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
                      onPressed: () {},
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const StudentsPage(),
                            ),
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
              title: const Text("Dersler"),
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
            )
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

import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_certificate_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_personel_info_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_education_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_experience_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_languages_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_settings_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_skills_tab.dart';
import 'package:tobeto/src/presentation/screens/platform/profile_edit_screen_tabs/edit_social_media_tab.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const EditPersonalInfoTab(),
    const EditExperienceTab(),
    const EditEducationTab(),
    const EditSkillsTab(),
    const EditCertificatesTab(),
    const EditSocialMediaTab(),
    const EditLanguagesTab(),
    const EditSettingsTab(),
  ];

  final List<IconData> _icons = [
    Icons.person,
    Icons.work,
    Icons.school,
    Icons.lightbulb,
    Icons.assignment,
    Icons.account_circle,
    Icons.language,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Image.asset(
                Assets.imagesTobetoLogo,
                width: 200,
              ),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              bottom: TabBar(
                indicatorColor: const Color.fromARGB(255, 153, 51, 255),
                dividerColor: const Color.fromARGB(255, 153, 51, 255),
                unselectedLabelColor: const Color.fromARGB(255, 153, 51, 255),
                labelColor: const Color.fromARGB(255, 153, 51, 255),
                controller: _tabController,
                isScrollable: true,
                tabs: List<Widget>.generate(_icons.length, (int index) {
                  return Tab(
                    icon: Icon(_icons[index]),
                  );
                }),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _pages,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/certificate.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/edit_personel_info.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/education.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/experience.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/languages.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/settings.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/skills.dart';
import 'package:tobeto/src/presentation/screens/profile/tabs/social_media.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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
    const PersonalInfoPage(),
    const ExperiencePage(),
    const EducationPage(),
    const SkillsPage(),
    const CertificatesPage(),
    const SocialMediaPage(),
    const LanguagesPage(),
    const SettingsPage(),
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
      drawer: const TBTDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: () {},
          child: Image.asset(
            Assets.imagesTobetoLogo,
            width: 180,
            height: 100,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: List<Widget>.generate(_icons.length, (int index) {
            return Tab(
              icon: Icon(_icons[index]),
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }
}
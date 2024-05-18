import 'package:flutter/material.dart';
import 'package:tobeto/armaganwidgets/edit_profile/certificate.dart';
import 'package:tobeto/armaganwidgets/edit_profile/clubs.dart';
import 'package:tobeto/armaganwidgets/edit_profile/edit_personel_info.dart';
import 'package:tobeto/armaganwidgets/edit_profile/education.dart';
import 'package:tobeto/armaganwidgets/edit_profile/experience.dart';
import 'package:tobeto/armaganwidgets/edit_profile/languages.dart';
import 'package:tobeto/armaganwidgets/edit_profile/projects_awards.dart';
import 'package:tobeto/armaganwidgets/edit_profile/settings.dart';
import 'package:tobeto/armaganwidgets/edit_profile/skills.dart';
import 'package:tobeto/armaganwidgets/edit_profile/social_media.dart';
import 'package:tobeto/constants/assets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PersonalInfoPage(),
    const ExperiencePage(),
    const EducationPage(),
    const SkillsPage(),
    const CertificatesPage(),
    const ClubsPage(),
    const ProjectsAndAwardsPage(),
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
    Icons.group,
    Icons.emoji_events,
    Icons.account_circle,
    Icons.language,
    Icons.settings,
  ];

  int _selectedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    Assets.imagesTobetoLogo,
                    width: 180,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < _icons.length; i++)
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(_icons[i]),
                              color: _selectedIconIndex == i
                                  ? const Color.fromRGBO(153, 51, 255, 1)
                                  : null,
                              onPressed: () {
                                setState(() {
                                  _currentIndex = i;
                                  _selectedIconIndex = i;
                                });
                              },
                            ),
                            if (_selectedIconIndex == i)
                              Container(
                                height: 2,
                                width: 24,
                                color: const Color(0xFF9933FF),
                              )
                            else
                              Container(),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }
}

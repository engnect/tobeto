import 'package:flutter/material.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  String? _selectedSocialMedia;
  final TextEditingController _linkController = TextEditingController();

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedSocialMedia,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Instagram',
                      child: Text('Instagram'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Twitter',
                      child: Text('Twitter'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'LinkedIn',
                      child: Text('LinkedIn'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Dribble',
                      child: Text('Dribble'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Behance',
                      child: Text('Behance'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Diğer',
                      child: Text('Diğer'),
                    ),
                  ];
                },
                onSelected: (String? newValue) {
                  setState(() {
                    _selectedSocialMedia = newValue;
                  });
                },
                child: ListTile(
                  title: Text(
                    _selectedSocialMedia ?? 'Sosyal Medya Hesabı Seçiniz',
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _linkController,
                decoration: const InputDecoration(
                  hintText: "https://",
                ),
                keyboardType: TextInputType.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(153, 51, 255, 1),
                ),
                child: const Text(
                  "Kaydet",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

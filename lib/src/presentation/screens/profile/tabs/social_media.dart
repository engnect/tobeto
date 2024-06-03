import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/auth/extract_login.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SocialMediaPageState createState() => _SocialMediaPageState();
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
      appBar: AppBar(
        title: const Text('Sosyal Medya'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
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
                ),
              ),
            ),
            const SizedBox(height: 24),
            TBTInputField(
                hintText: "https://",
                controller: _linkController,
                onSaved: (p0) {},
                keyboardType: TextInputType.url),
            const SizedBox(height: 16),
            TBTPurpleButton(
              buttonText: 'Kaydet',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

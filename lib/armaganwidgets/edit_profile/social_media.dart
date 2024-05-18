import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedSocialMedia,
              onChanged: (newValue) {
                setState(() {
                  _selectedSocialMedia = newValue;
                });
              },
              items: <String>[
                'Instagram',
                'Twitter',
                'LınkedIn',
                'Dribble',
                'Behance',
                'Diğer',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Sosyal Medya Hesabı Seçiniz',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), 
              ),
            ),
            const SizedBox(height: 16),
            
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(
                  labelText: 'https://',
                  contentPadding: EdgeInsets.all(8), 
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(153, 51, 255, 1),
                ),
                child: const Text("Kaydet",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

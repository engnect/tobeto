import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String? _selectedLanguage;
  String? _selectedLevel;

  final List<String> _languages = [
    'Almanca',
    'Arapça',
    'Çekçe',
    'Çince(Mandarin)',
    'Danca',
    'Fince',
    'Fransızca',
    'Hindi',
    'Hollandaca',
    'İbranice',
    'İngilizce',
    'İspanyolca',
    'İsveççe',
    'İtalyanca',
    'Japonca',
    'Korece',
    'Lehçe',
    'Macarca',
    'Norveççe',
    'Portekizce',
    'Romence',
    'Rusça',
    'Türkçe',
    'Vietnamca',
    'Yunanca',
  ];

  final List<String> _levels = [
    'Temel Seviye(A1,A2)',
    'Orta Seviye(B1,B2)',
    'İleri Seviye(C1,C2)',
    'Ana Dil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedLanguage,
                itemBuilder: (BuildContext context) {
                  return _languages
                      .map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
                onSelected: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
                child: ListTile(
                  title: Text(
                    _selectedLanguage ?? 'Yabancı Dil Seçiniz',
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedLevel,
                itemBuilder: (BuildContext context) {
                  return _levels.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
                onSelected: (String? newValue) {
                  setState(() {
                    _selectedLevel = newValue;
                  });
                },
                child: ListTile(
                  title: Text(
                    _selectedLevel ?? 'Seviye Seçiniz',
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TBTPurpleButton(
              buttonText: 'Kaydet',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

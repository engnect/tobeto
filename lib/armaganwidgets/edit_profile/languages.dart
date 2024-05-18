import 'package:flutter/material.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String? _selectedLanguage;
  String? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              },
              items: <String>[
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
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Yabancı Dil Seçiniz',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedLevel,
              onChanged: (newValue) {
                setState(() {
                  _selectedLevel = newValue;
                });
              },
              items: <String>[
                'Temel Seviye(A1,A2)',
                'Orta Seviye(B1,B2)',
                'İleri Seviye(C1,C2)',
                'Ana Dil',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Seviye Seçiniz',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
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

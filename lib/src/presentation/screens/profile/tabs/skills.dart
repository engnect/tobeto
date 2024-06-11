import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/profile/padded_widget';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final TextEditingController _skillController = TextEditingController();
  final List<String> _selectedSkills = [];
  final List<String> _availableSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'Node.js',
    'React',
    'Python'
  ];

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill(String skill) {
    setState(() {
      _selectedSkills.add(skill);
      _skillController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PaddedWidget(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _skillController,
                        decoration: const InputDecoration(
                          hintText: 'Yetenek Adı',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String skill = _skillController.text.trim();
                        if (skill.isNotEmpty) {
                          _addSkill(skill);
                        }
                      },
                      child: const Text('Ekle'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PaddedWidget(
                child: Wrap(
                  spacing: 8,
                  children: _selectedSkills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          onDeleted: () {
                            setState(() {
                              _selectedSkills.remove(skill);
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              PaddedWidget(
                child: DropdownButtonFormField<String>(
                  value: null,
                  hint: const Text('Mevcut yetkinlik Seç'),
                  items: _availableSkills.map((String skill) {
                    return DropdownMenuItem<String>(
                      value: skill,
                      child: Text(skill),
                    );
                  }).toList(),
                  onChanged: (selectedSkill) {
                    if (selectedSkill != null) {
                      _addSkill(selectedSkill);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tobeto/src/models/language_model.dart';

class EditLanguageDialog extends StatefulWidget {
  final LanguageModel languageModel;
  final List<String> languages;
  final List<String> levels;

  const EditLanguageDialog({
    super.key,
    required this.languageModel,
    required this.languages,
    required this.levels,
  });

  @override
  State<EditLanguageDialog> createState() => _EditLanguageDialogState();
}

class _EditLanguageDialogState extends State<EditLanguageDialog> {
  String? _selectedLanguage;
  String? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.languageModel.languageName;
    _selectedLevel = widget.languageModel.languageLevel;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Yabancı Dil Seçiniz", 
      style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedLanguage,
                itemBuilder: (BuildContext context) {
                  return widget.languages.map<PopupMenuItem<String>>((String value) {
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
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedLevel,
                itemBuilder: (BuildContext context) {
                  return widget.levels.map<PopupMenuItem<String>>((String value) {
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
                     style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            LanguageModel updatedLanguage = LanguageModel(
              languageId: widget.languageModel.languageId,
              userId: widget.languageModel.userId,
              languageName: _selectedLanguage,
              languageLevel: _selectedLevel,
            );
            Navigator.pop(context, updatedLanguage);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}

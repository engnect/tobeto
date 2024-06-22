import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/domain/repositories/language_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/edit_language_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/purple_button.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String? _selectedLanguage;
  String? _selectedLevel;
  bool isSelect = false;

  final List<String> _languages = [
    'Almanca', 'Arapça', 'Çekçe', 'Çince(Mandarin)', 'Danca',
    'Fince', 'Fransızca', 'Hindi', 'Hollandaca', 'İbranice',
    'İngilizce', 'İspanyolca', 'İsveççe', 'İtalyanca', 'Japonca',
    'Korece', 'Lehçe', 'Macarca', 'Norveççe', 'Portekizce',
    'Romence', 'Rusça', 'Türkçe', 'Vietnamca', 'Yunanca',
  ];

  final List<String> _levels = [
    'Temel Seviye(A1,A2)', 'Orta Seviye(B1,B2)', 'İleri Seviye(C1,C2)', 'Ana Dil',
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TBTPurpleButton(
              buttonText: "Düzenle",
              onPressed: () {
                setState(() {
                  isSelect = !isSelect;
                });
              },
            ),
            const SizedBox(height: 8.0),
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: isSelect
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : null,
                border: Border(
                  bottom: BorderSide(
                    width: isSelect ? 7 : 0,
                    color: const Color.fromARGB(255, 153, 51, 255),
                  ),
                ),
              ),
              height: isSelect ? 600 : 0,
              duration: const Duration(seconds: 1),
              child: isSelect
                  ? BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is Authenticated) {
                          UserModel currentUser = state.userModel;

                          return ListView.builder(
                            itemCount: currentUser.languageList!.length,
                            itemBuilder: (context, index) {
                              LanguageModel language =
                                  currentUser.languageList![index];
                              return Card(
                                child: ListTile(
                                  title: Text(language.languageName!),
                                  subtitle: Text(language.languageLevel!),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          final updatedLanguage =
                                              await showDialog<LanguageModel>(
                                            context: context,
                                           builder: (context) =>
                                                EditLanguageDialog(
                                                  languageModel: language,
                                                  languages: _languages,
                                                  levels: _levels,
                                                ),
                                          );
                                          if (updatedLanguage != null) {
                                            String result =
                                                await LanguageRepository()
                                                    .updateLanguage(
                                              updatedLanguage,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text("Dili sil"),
                                              content: const Text(
                                                  "Bu dili silmek istediğinizden emin misiniz?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("İptal"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    String result =
                                                        await LanguageRepository()
                                                            .deleteLanguage(
                                                                language);
                                                    print(result);
                                                  },
                                                  child: const Text('Sil'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedLanguage,
                itemBuilder: (BuildContext context) {
                  return _languages.map<PopupMenuItem<String>>((String value) {
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
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                ),
              ),
            ),
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
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () async {
                  UserModel? userModel =
                      await UserRepository().getCurrentUser();
                  LanguageModel newLanguage = LanguageModel(
                    languageId: const Uuid().v1(),
                    userId: userModel!.userId,
                    languageName: _selectedLanguage,
                    languageLevel: _selectedLevel,
                  );
                  String result =
                      await LanguageRepository().addLanguage(newLanguage);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

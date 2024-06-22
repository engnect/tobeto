import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
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

  void _saveLanguage({
    required String languageName,
    required String languageLevel,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    LanguageModel newLanguage = LanguageModel(
      languageId: const Uuid().v1(),
      userId: userModel!.userId,
      languageName: languageName,
      languageLevel: languageLevel,
    );
    String result = await LanguageRepository().addLanguage(newLanguage);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _deleteLanguage(
      {required LanguageModel languageModel, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Dili sil",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "Bu dili silmek istediğinizden emin misiniz?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "İptal",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              String result =
                  await LanguageRepository().deleteLanguage(languageModel);

              if (!context.mounted) return;
              Utilities.showSnackBar(snackBarMessage: result, context: context);
            },
            child: Text(
              'Sil',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editLanguage({
    required List<String> languages,
    required List<String> levels,
    required LanguageModel languageModel,
    required BuildContext context,
  }) async {
    final updatedLanguage = await showDialog<LanguageModel>(
      context: context,
      builder: (context) => EditLanguageDialog(
        languageModel: languageModel,
        languages: languages,
        levels: levels,
      ),
    );
    if (updatedLanguage != null) {
      String result = await LanguageRepository().updateLanguage(
        updatedLanguage,
      );
      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
    }
  }

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
              height: isSelect ? 350 : 0,
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
                                color: Theme.of(context).colorScheme.background,
                                child: ListTile(
                                  title: Text(
                                    language.languageName!,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  subtitle: Text(
                                    language.languageLevel!,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                        onPressed: () async {
                                          _editLanguage(
                                            languageModel: language,
                                            languages: _languages,
                                            levels: _levels,
                                            context: context,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                        onPressed: () => _deleteLanguage(
                                          languageModel: language,
                                          context: context,
                                        ),
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
                color: Theme.of(context).colorScheme.background,
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                color: Theme.of(context).colorScheme.background,
                initialValue: _selectedLevel,
                itemBuilder: (BuildContext context) {
                  return _levels.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () => _saveLanguage(
                  languageLevel: _selectedLevel!,
                  languageName: _selectedLanguage!,
                  context: context,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

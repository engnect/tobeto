import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class EditLanguagesTab extends StatefulWidget {
  const EditLanguagesTab({super.key});

  @override
  State<EditLanguagesTab> createState() => _EditLanguagesTabState();
}

class _EditLanguagesTabState extends State<EditLanguagesTab> {
  String? _selectedLanguage;
  String? _selectedLevel;
  bool isSelect = true;

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
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    LanguageModel newLanguage = LanguageModel(
      languageId: const Uuid().v1(),
      userId: userModel!.userId,
      languageName: languageName,
      languageLevel: languageLevel,
    );
    String result = await LanguageRepository().addLanguage(newLanguage);

    if (result == 'success' || result == 'İşlem Başarılı!') {
      Utilities.showToast(toastMessage: 'İşlem Başarılı!');
    } else {
      Utilities.showToast(toastMessage: result);
    }
  }

  void _deleteLanguage({
    required LanguageModel languageModel,
    required BuildContext context,
  }) {
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

              Utilities.showToast(toastMessage: result);
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
      Utilities.showToast(toastMessage: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TBTAnimatedContainer(
                    height: 400,
                    infoText: 'Yeni Dil Ekle!',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton<String>(
                            color: Theme.of(context).colorScheme.background,
                            initialValue: _selectedLanguage,
                            itemBuilder: (BuildContext context) {
                              return _languages
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )),
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
                                _selectedLanguage ?? 'Yabancı Dil Seçiniz*',
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
                              return _levels
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                _selectedLevel ?? 'Seviye Seçiniz*',
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
                            onPressed: () {
                              if (_selectedLevel == null ||
                                  _selectedLanguage == null) {
                                Utilities.showToast(
                                    toastMessage: 'Bütün alanları doldurunuz!');
                              } else {
                                _saveLanguage(
                                  languageLevel: _selectedLevel!,
                                  languageName: _selectedLanguage!,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        UserModel currentUser = state.userModel;

                        return currentUser.languageList!.isEmpty
                            ? const Center(
                                child: Text("Eklenmiş dil bilgisi bulunamadı!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: currentUser.languageList!.length,
                                itemBuilder: (context, index) {
                                  LanguageModel language =
                                      currentUser.languageList![index];
                                  return Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/social_media_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/social_media_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/edit_social_media_dialog.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:uuid/uuid.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  String? _selectedSocialMedia;
  final TextEditingController _linkController = TextEditingController();
  bool isSelect = true;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  String _getAssetUrl(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return 'assets/images/instagram.PNG';
      case 'linkedin':
        return 'assets/images/linkedin.PNG';
      case 'twitter':
        return 'assets/images/twitter.jpg';
      case 'dribble':
        return 'assets/images/dribbble.png';
      case 'behance':
        return 'assets/images/behance.png';
      default:
        return 'assets/images/default.png';
    }
  }

  void _saveSocialMedia({
    required String selectedSocialMedia,
    required String socialMedialink,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String assetUrl = _getAssetUrl(selectedSocialMedia);

    SocialMediaModel socialMediaModel = SocialMediaModel(
      socialMediaId: const Uuid().v1(),
      userId: userModel!.userId,
      socialMediaPlatform: selectedSocialMedia,
      socialMedialink: socialMedialink,
      socialMediaAssetUrl: assetUrl,
    );

    String result =
        await SocialMediaRepository().addSocialMedia(socialMediaModel);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _editSocialMedia({
    required SocialMediaModel socialMediaModel,
    required BuildContext context,
  }) async {
    final updatedSocialMedia = await showDialog<SocialMediaModel>(
      context: context,
      builder: (context) =>
          EditSocialMediaDialog(socialMedia: socialMediaModel),
    );
    if (updatedSocialMedia != null) {
      String result = await SocialMediaRepository().updateSocialMedia(
        updatedSocialMedia,
      );
      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
      setState(() {});
    }
  }

  void _deleteSocialMedia({
    required SocialMediaModel socialMediaModel,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Sosyal medya ehsabını sil ",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "Bu Sosyal Medya hesabını silmek istediğinizden emin misiniz?",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "İptal",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              String result = await SocialMediaRepository()
                  .deleteSocialMedia(socialMediaModel);
              if (!context.mounted) return;
              Utilities.showSnackBar(snackBarMessage: result, context: context);
            },
            child: Text(
              'Sil',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TBTPurpleButton(
                buttonText: "Düzenle",
                onPressed: () {
                  setState(() {
                    isSelect = !isSelect;
                  });
                },
              ),
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

                           return currentUser.socialMediaList!.isEmpty
                            ? const Center(
                                child: Text("Eklenmiş sosyal medya bulunamadı!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                              )
                            : ListView.builder(
                              itemCount: currentUser.socialMediaList!.length,
                              itemBuilder: (context, index) {
                                SocialMediaModel socialMedia =
                                    currentUser.socialMediaList![index];
                                return Card(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                          socialMedia.socialMediaAssetUrl),
                                    ),
                                    title: Text(
                                      socialMedia.socialMediaPlatform,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    subtitle: Text(
                                      socialMedia.socialMedialink,
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
                                          onPressed: () => _editSocialMedia(
                                            socialMediaModel: socialMedia,
                                            context: context,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          onPressed: () => _deleteSocialMedia(
                                            socialMediaModel: socialMedia,
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
                  initialValue: _selectedSocialMedia,
                  itemBuilder: (BuildContext context) {
                    return [
                      'Instagram',
                      'Twitter',
                      'LinkedIn',
                      'Dribble',
                      'Behance'
                    ].map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      );
                    }).toList();
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedSocialMedia = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      _selectedSocialMedia ?? 'Sosyal medya hesabı seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "https://",
                  controller: _linkController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () => _saveSocialMedia(
                  selectedSocialMedia: _selectedSocialMedia!,
                  socialMedialink: _linkController.text,
                  context: context,
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

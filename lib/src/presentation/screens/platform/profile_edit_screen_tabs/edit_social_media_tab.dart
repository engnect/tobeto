import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class EditSocialMediaTab extends StatefulWidget {
  const EditSocialMediaTab({super.key});

  @override
  State<EditSocialMediaTab> createState() => _EditSocialMediaTabState();
}

class _EditSocialMediaTabState extends State<EditSocialMediaTab> {
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
        return Assets.imageInstagram;
      case 'linkedin':
        return Assets.imageLinkedin;
      case 'twitter':
        return Assets.imageTwitter;
      case 'dribble':
        return Assets.imageDribble;
      case 'behance':
        return Assets.imageBehance;
      default:
        return 'assets/images/default.png';
    }
  }

  bool _validateInstagramUrl(String url) {
    RegExp regex = RegExp(
        r'^(http(?:s)?:\/\/)?(?:www\.)?instagram\.com\/[a-zA-Z0-9_.]{1,30}\/?$');
    return regex.hasMatch(url);
  }

  bool _validateLinkedinUrl(String url) {
    RegExp regex = RegExp(
        r'^(http(?:s)?:\/\/)?(?:www\.)?linkedin\.com\/[a-zA-Z0-9_.]{1,30}\/?$');
    return regex.hasMatch(url);
  }

  bool _validateTwitterUrl(String url) {
    RegExp regex = RegExp(
        r'^(http(?:s)?:\/\/)?(?:www\.)?twitter\.com\/[a-zA-Z0-9_]{1,15}\/?$');
    return regex.hasMatch(url);
  }

  bool _validateDribbleUrl(String url) {
    RegExp regex = RegExp(
        r'^(http(?:s)?:\/\/)?(?:www\.)?dribble\.com\/[a-zA-Z0-9_.]{1,30}\/?$');
    return regex.hasMatch(url);
  }

  bool _validateBehanceUrl(String url) {
    RegExp regex = RegExp(
        r'^(http(?:s)?:\/\/)?(?:www\.)?behance\.net\/[a-zA-Z0-9_-]{1,50}\/?$');
    return regex.hasMatch(url);
  }

  void _saveSocialMedia({
    required String selectedSocialMedia,
    required String socialMediaLink,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String assetUrl = _getAssetUrl(selectedSocialMedia);

    bool isValid = true;
    String errorMessage = '';

    switch (selectedSocialMedia.toLowerCase()) {
      case 'instagram':
        isValid = _validateInstagramUrl(socialMediaLink);
        errorMessage = 'Geçersiz Instagram adresi';
        break;
      case 'linkedin':
        isValid = _validateLinkedinUrl(socialMediaLink);
        errorMessage = 'Geçersiz LinkedIn adresi';
        break;
      case 'twitter':
        isValid = _validateTwitterUrl(socialMediaLink);
        errorMessage = 'Geçersiz Twitter adresi';
        break;
      case 'dribble':
        isValid = _validateDribbleUrl(socialMediaLink);
        errorMessage = 'Geçersiz Dribble adresi';
        break;
      case 'behance':
        isValid = _validateBehanceUrl(socialMediaLink);
        errorMessage = 'Geçersiz Behance adresi';
        break;
      default:
        isValid = false;
        errorMessage = 'Bilinmeyen sosyal medya platformu';
    }

    if (!isValid) {
      Utilities.showToast(toastMessage: errorMessage);
      return;
    }

    SocialMediaModel socialMediaModel = SocialMediaModel(
      socialMediaId: const Uuid().v1(),
      userId: userModel!.userId,
      socialMediaPlatform: selectedSocialMedia,
      socialMedialink: socialMediaLink,
      socialMediaAssetUrl: assetUrl,
    );

    String result =
        await SocialMediaRepository().addSocialMedia(socialMediaModel);
    Utilities.showToast(toastMessage: result);
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
      Utilities.showToast(toastMessage: result);
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
          "Sosyal medya hesabını sil",
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
              Utilities.showToast(toastMessage: result);
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TBTAnimatedContainer(
                    height: 250,
                    infoText: 'Yeni Sosyal Medya Hesabı Ekle!',
                    child: Column(
                      children: [
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
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
                                _selectedSocialMedia ??
                                    'Sosyal medya hesabı seçiniz',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              trailing: Icon(
                                Icons.arrow_drop_down,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                          onPressed: () {
                            if (_selectedSocialMedia == null) {
                              Utilities.showToast(
                                  toastMessage:
                                      'Sosyal Medya Platformu Boş Bırakılamaz!');
                            } else {
                              _saveSocialMedia(
                                selectedSocialMedia: _selectedSocialMedia!,
                                socialMediaLink: _linkController.text,
                              );
                            }
                          },
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
                        return currentUser.socialMediaList!.isEmpty
                            ? const Center(
                                child: Text(
                                  "Eklenmiş sosyal medya bulunamadı!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: currentUser.socialMediaList!.length,
                                itemBuilder: (context, index) {
                                  SocialMediaModel socialMedia =
                                      currentUser.socialMediaList![index];
                                  return Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 18,
                                        backgroundImage: AssetImage(
                                          socialMedia.socialMediaAssetUrl,
                                        ),
                                      ),
                                      title: Text(
                                        socialMedia.socialMediaPlatform,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      subtitle: Text(
                                        socialMedia.socialMedialink,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
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

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
  bool isSelect = false;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  // Widget _buildEditSocialMediaDialog(SocialMediaModel socialMedia) {
  //   _selectedSocialMedia = socialMedia.socialMediaPlatform;
  //   _linkController.text = socialMedia.socialMedialink;

  //   return StatefulBuilder(
  //   builder: (BuildContext context, StateSetter setState) {
  //   return AlertDialog(
  //     title: const Text("Sosyal Medya Hesabını Düzenle"),
  //     content: SingleChildScrollView(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             child: PopupMenuButton<String>(
  //               initialValue: _selectedSocialMedia,
  //               itemBuilder: (BuildContext context) {
  //                 return <PopupMenuEntry<String>>[
  //                   const PopupMenuItem<String>(
  //                     value: 'Instagram',
  //                     child: Text('Instagram'),
  //                   ),
  //                   const PopupMenuItem<String>(
  //                     value: 'Twitter',
  //                     child: Text('Twitter'),
  //                   ),
  //                   const PopupMenuItem<String>(
  //                     value: 'LinkedIn',
  //                     child: Text('LinkedIn'),
  //                   ),
  //                   const PopupMenuItem<String>(
  //                     value: 'Dribble',
  //                     child: Text('Dribble'),
  //                   ),
  //                   const PopupMenuItem<String>(
  //                     value: 'Behance',
  //                     child: Text('Behance'),
  //                   ),
  //                 ];
  //               },
  //               onSelected: (String? newValue) {
  //                 setState(() {
  //                   _selectedSocialMedia = newValue;
  //                 });
  //               },
  //               child: ListTile(
  //                 title: Text(
  //                   _selectedSocialMedia ?? 'Sosyal Medya Hesabı Seçiniz',
  //                 ),
  //                 trailing: const Icon(Icons.arrow_drop_down),
  //                 contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
  //               ),
  //             ),
  //           ),
  //           TextField(
  //             controller: _linkController,
  //             decoration: const InputDecoration(labelText: "https://",contentPadding:  EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),),
  //           ),
  //         ],
  //       ),
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () => Navigator.pop(context),
  //         child: const Text("İptal"),
  //       ),
  //       TextButton(
  //         onPressed: () {
  //           SocialMediaModel updatedSocialMedia = SocialMediaModel(
  //             socialMediaId: socialMedia.socialMediaId,
  //             userId: socialMedia.userId,
  //             socialMediaPlatform: _selectedSocialMedia.toString(),
  //             socialMedialink: _linkController.text,
  //           );
  //           Navigator.pop(context, updatedSocialMedia);
  //         },
  //         child: const Text("Kaydet"),
  //       ),
  //     ],
  //   );
  // }
  // );

  // }

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

                            return ListView.builder(
                              itemCount: currentUser.socialMediaList!.length,
                              itemBuilder: (context, index) {
                                SocialMediaModel socialMedia =
                                    currentUser.socialMediaList![index];
                                return Card(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: ListTile(
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
                                          onPressed: () async {
                                            final updatedSocialMedia =
                                                await showDialog<
                                                    SocialMediaModel>(
                                              context: context,
                                              builder: (context) =>
                                                  EditSocialMediaDialog(
                                                      socialMedia: socialMedia),
                                            );
                                            if (updatedSocialMedia != null) {
                                              String result =
                                                  await SocialMediaRepository()
                                                      .updateSocialMedia(
                                                updatedSocialMedia,
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
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Sosyal medya ehsabını sil ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                                content: Text(
                                                  "Bu Sosyal Medya hesabını silmek istediğinizden emin misiniz?",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text(
                                                      "İptal",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);

                                                      String result =
                                                          await SocialMediaRepository()
                                                              .deleteSocialMedia(
                                                                  socialMedia);

                                                      Utilities.showSnackBar(
                                                          snackBarMessage:
                                                              result,
                                                          context: context);
                                                    },
                                                    child: Text(
                                                      'Sil',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
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
                onPressed: () async {
                  UserModel? userModel =
                      await UserRepository().getCurrentUser();

                  SocialMediaModel socialMediaModel = SocialMediaModel(
                    socialMediaId: const Uuid().v1(),
                    userId: userModel!.userId,
                    socialMediaPlatform: _selectedSocialMedia.toString(),
                    socialMedialink: _linkController.text,
                  );

                  String result = await SocialMediaRepository()
                      .addSocialMedia(socialMediaModel);
                  Utilities.showSnackBar(
                      snackBarMessage: result, context: context);
                },
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

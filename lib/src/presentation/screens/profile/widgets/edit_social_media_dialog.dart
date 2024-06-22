import 'package:flutter/material.dart';
import 'package:tobeto/src/models/social_media_model.dart';

class EditSocialMediaDialog extends StatefulWidget {
  final SocialMediaModel socialMedia;

  const EditSocialMediaDialog({super.key, required this.socialMedia});

  @override
  State<EditSocialMediaDialog> createState() => _EditSocialMediaDialogState();
}

class _EditSocialMediaDialogState extends State<EditSocialMediaDialog> {
  String? _selectedSocialMedia;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _selectedSocialMedia = widget.socialMedia.socialMediaPlatform;
    _linkController = TextEditingController(text: widget.socialMedia.socialMedialink);
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sosyal Medya Hesabını Düzenle"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PopupMenuButton<String>(
                initialValue: _selectedSocialMedia,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Instagram',
                      child: Text('Instagram'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Twitter',
                      child: Text('Twitter'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'LinkedIn',
                      child: Text('LinkedIn'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Dribble',
                      child: Text('Dribble'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Behance',
                      child: Text('Behance'),
                    ),
                  ];
                },
                onSelected: (String? newValue) {
                  setState(() {
                    _selectedSocialMedia = newValue;
                  });
                },
                child: ListTile(
                  title: Text(
                    _selectedSocialMedia ?? 'Sosyal Medya Hesabı Seçiniz',
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                ),
              ),
            ),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(labelText: "https://"),
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
            SocialMediaModel updatedSocialMedia = SocialMediaModel(
              socialMediaId: widget.socialMedia.socialMediaId,
              userId: widget.socialMedia.userId,
              socialMediaPlatform: _selectedSocialMedia ?? '',
              socialMedialink: _linkController.text,
            );
            Navigator.pop(context, updatedSocialMedia);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}

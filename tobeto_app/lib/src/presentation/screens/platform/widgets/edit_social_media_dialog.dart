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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sosyal Medya Hesabını Düzenle", 
       style: TextStyle(color: Theme.of(context).colorScheme.primary),
       ),
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
                     style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                ),
              ),
            ),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              controller: _linkController,
              decoration:  InputDecoration(labelText: "https://", 
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
            String assetUrl = _getAssetUrl(_selectedSocialMedia!);
            SocialMediaModel updatedSocialMedia = SocialMediaModel(
              socialMediaId: widget.socialMedia.socialMediaId,
              userId: widget.socialMedia.userId,
              socialMediaPlatform: _selectedSocialMedia ?? '',
              socialMedialink: _linkController.text,
              socialMediaAssetUrl: assetUrl,
            );
            Navigator.pop(context, updatedSocialMedia);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}

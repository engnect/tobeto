import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';
import 'package:tobeto/src/common/export_common.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';
import 'widgets/widgets.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
  }

  Future<String> _sendContactForm({
    required String formFullname,
    required String formEmail,
    required String formMessage,
    required BuildContext context,
  }) async {
    ContactFormModel contactFormModel = ContactFormModel(
      contactFormId: const Uuid().v1(),
      contactFormFullName: formFullname,
      contactFormEmail: formEmail,
      contactFormMessage: formMessage,
      contactFormCreatedAt: DateTime.now(),
      contactFormIsClosed: false,
      contactFormClosedBy: 'contactFormClosedBy',
      contactFormClosedAt: DateTime.now(),
    );

    return await ContactFromRepository().sendOrUpdateForm(contactFormModel);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color.fromARGB(255, 153, 51, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  context.translate.get_in_touch,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              context.translate.contact_info,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.company_name,
                              info: "TOBETO",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.company_title,
                              info:
                                  "Avez Elektronik İletişim Eğitim Danışmanlığı Ticaret Anonim Şirketi",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.tax_office,
                              info: "Beykoz",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.tax_number,
                              info: "1050250859",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.phone,
                              info: "(0216) 331 48 00",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.email,
                              info: "info@tobeto.com",
                            ),
                            CommunicationInfo(
                              headerinfo: context.translate.address,
                              info:
                                  "Kavacık, Rüzgarlıbahçe Mah. Çampınarı Sok. No:4 Smart Plaza B Blok Kat:3 34805, Beykoz/İstanbul",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 8,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Color.fromARGB(255, 153, 51, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  context.translate.text_message,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              context.translate.contact_form,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 25,
                                horizontal: 20,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TBTInputField(
                                        hintText:
                                            context.translate.name_surname,
                                        controller: _nameController,
                                        onSaved: (p0) {},
                                        keyboardType: TextInputType.multiline),
                                    TBTInputField(
                                        hintText: context.translate.email,
                                        controller: _emailController,
                                        onSaved: (p0) {},
                                        keyboardType:
                                            TextInputType.emailAddress),
                                    TBTInputField(
                                      hintText: context.translate.message,
                                      controller: _messageController,
                                      onSaved: (p0) {},
                                      keyboardType: TextInputType.multiline,
                                      minLines: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TBTPurpleButton(
                              width: 200,
                              buttonText: context.translate.send,
                              onPressed: () async {
                                if (_nameController.text.trim() != '' &&
                                    _emailController.text.trim() != '' &&
                                    _messageController.text.trim() != '') {
                                  String result = await _sendContactForm(
                                    formFullname: _nameController.text.trim(),
                                    formEmail: _emailController.text.trim(),
                                    formMessage: _messageController.text.trim(),
                                    context: context,
                                  );
                                  if ((result == 'success' ||
                                          result == 'İşlem Başarılı!') &&
                                      context.mounted) {
                                    PanaraInfoDialog.showAnimatedFade(
                                      context,
                                      barrierDismissible: false,
                                      color: Colors.purple,
                                      title: "Teşekkürler!",
                                      textColor:
                                          Theme.of(context).colorScheme.primary,
                                      message:
                                          "Mesajınız bize ulaştı. En kısa zamanda konu ile ilgili size dönüş sağlayacağız.",
                                      buttonText: "İyi günler!",
                                      onTapDismiss: () {
                                        Navigator.pop(context);
                                      },
                                      panaraDialogType: PanaraDialogType.custom,
                                    );

                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                  } else {
                                    if (!context.mounted) return;
                                    Utilities.showSnackBar(
                                      snackBarMessage: 'Hata : $result',
                                      context: context,
                                    );
                                  }
                                } else {
                                  Utilities.showSnackBar(
                                    snackBarMessage:
                                        'Bütün alanları doldurunuz!',
                                    context: context,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

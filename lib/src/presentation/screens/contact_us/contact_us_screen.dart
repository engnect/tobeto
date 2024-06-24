import 'package:flutter/material.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';
import 'package:tobeto/src/domain/repositories/contact_form_repository.dart';
import 'package:tobeto/src/models/contact_form_model.dart';
import 'package:tobeto/src/presentation/screens/contact_us/widgets/communication_info.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/input_field.dart';
import '../../widgets/purple_button.dart';

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
                            //----------------------------------
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
                                  "	Kavacık, Rüzgarlıbahçe Mah. Çampınarı Sok. No:4 Smart Plaza B Blok Kat:3 34805, Beykoz/İstanbul",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                                  vertical: 25, horizontal: 20),
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
                                ContactFormModel contactFormModel =
                                    ContactFormModel(
                                  contactFormId: const Uuid().v1(),
                                  contactFormFullName: _nameController.text,
                                  contactFormEmail: _emailController.text,
                                  contactFormMessage: _messageController.text,
                                  contactFormCreatedAt: DateTime.now(),
                                  contactFormIsClosed: false,
                                  contactFormClosedBy: 'contactFormClosedBy',
                                  contactFormClosedAt: DateTime.now(),
                                );

                                var result = await ContactFromRepository()
                                    .sendOrUpdateForm(contactFormModel);

                                if (result == 'success' && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('İşlem Başarılı'),
                                    ),
                                  );
                                  _nameController.clear();
                                  _emailController.clear();
                                  _messageController.clear();
                                } else if (result != 'success' &&
                                    context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('İşlem Başarılı'),
                                    ),
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

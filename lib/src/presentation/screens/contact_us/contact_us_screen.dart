import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/contact_form_repository.dart';
import 'package:tobeto/src/models/contact_form_model.dart';
import 'package:tobeto/src/presentation/screens/contact_us/widgets/communication_info.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
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
  final ScrollController _controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: TBTAppBar(controller: _controller),
        drawer: const TBTDrawer(),
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 153, 51, 255),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "İletişime Geçin",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "İletişime Bilgileri",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                      ),
                    ),
                    //----------------------------------
                    const CommunicationInfo(
                      headerinfo: "Firma Adı:",
                      info: "TOBETO",
                    ),
                    const CommunicationInfo(
                      headerinfo: "Firma Unvan:",
                      info:
                          "Avez Elektronik İletişim Eğitim Danışmanlığı Ticaret Anonim Şirketi",
                    ),
                    const CommunicationInfo(
                      headerinfo: "Vergi Dairesi:",
                      info: "Beykoz",
                    ),
                    const CommunicationInfo(
                      headerinfo: "Vergi No:",
                      info: "1050250859",
                    ),
                    const CommunicationInfo(
                      headerinfo: "Telefon:",
                      info: "(0216) 331 48 00",
                    ),
                    const CommunicationInfo(
                      headerinfo: "E-Posta:",
                      info: "info@tobeto.com",
                    ),
                    const CommunicationInfo(
                      headerinfo: "Adres:",
                      info:
                          "	Kavacık, Rüzgarlıbahçe Mah. Çampınarı Sok. No:4 Smart Plaza B Blok Kat:3 34805, Beykoz/İstanbul",
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 153, 51, 255),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Mesaj Bırakın",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Text(
                      "İletişim Formu",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
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
                                hintText: "Adınız Soyadınız",
                                controller: _nameController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline),
                            TBTInputField(
                                hintText: "E - Mail",
                                controller: _emailController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.emailAddress),
                            TBTInputField(
                              hintText: "Mesajınız",
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
                      buttonText: "Gönder",
                      onPressed: () async {
                        ContactFormModel contactFormModel = ContactFormModel(
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
                        } else if (result != 'success' && context.mounted) {
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
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/screens/communication_page/widgets/communication_info.dart';
import 'package:tobeto/screens/login_register_screen/extract_login.dart';
import 'package:tobeto/widgets/tbt_drawer_widget.dart';

import '../../constants/assets.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            Assets.imagesTobetoLogo,
            width: 200,
          ),
          backgroundColor: Colors.white,
        ),
        drawer: const TbtDrawer(),
        body: SingleChildScrollView(
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
                              fontWeight: FontWeight.bold),
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
                    const Communicationinfo(
                      headerinfo: "Firma Adı:",
                      info: "TOBETO",
                    ),
                    const Communicationinfo(
                      headerinfo: "Firma Unvan:",
                      info:
                          "Avez Elektronik İletişim Eğitim Danışmanlığı Ticaret Anonim Şirketi",
                    ),
                    const Communicationinfo(
                        headerinfo: "Vergi Dairesi:", info: "Beykoz"),
                    const Communicationinfo(
                        headerinfo: "Vergi No:", info: "1050250859"),
                    const Communicationinfo(
                        headerinfo: "Telefon:", info: "(0216) 331 48 00"),
                    const Communicationinfo(
                        headerinfo: "E-Posta:", info: "info@tobeto.com"),
                    const Communicationinfo(
                        headerinfo: "Adres:",
                        info:
                            "	Kavacık, Rüzgarlıbahçe Mah. Çampınarı Sok. No:4 Smart Plaza B Blok Kat:3 34805, Beykoz/İstanbul")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                controller: nameController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline),
                            TBTInputField(
                                hintText: "E-Mail",
                                controller: emailController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.emailAddress),
                            TBTInputField(
                              hintText: "Mesajınız",
                              controller: messageController,
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
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

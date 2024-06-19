import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_date_and_content_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_language_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_skills_widget.dart';

class ProfilDetails extends StatelessWidget {
  const ProfilDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilim"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(240, 240, 240, 1),
          child: Column(
            children: [
              //İsim Ve Soyisim Kısmı
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Assets.imagesMhProfil),
                            radius: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ad Soyad",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    color: Color.fromRGBO(111, 111, 111, 1)),
                              ),
                              const Text(
                                "Muhammed Hocaoglu",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    "https://github.com/Muhammedhcgl1",
                                    style: TextStyle(
                                        color: Color.fromRGBO(11, 87, 208, 1)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  AssetImage(Assets.imageInstagram),
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(Assets.imageLinkedin),
                          ),
                          Spacer(),
                          Icon(
                            Icons.edit_square,
                            size: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.share_outlined,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //Hakkımda Kısmı
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hakkımda",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "hakkımda ıvır zıvır asdas sad as asdasdasd  asdasdasdasd asdasdasdas  dasdasdasd  dasdasddas  dasdasdasd asdasdad dsada dasdasda dasda",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              //Kişisel Bilgiler
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kişisel Bilgiler",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    Text(
                      "Doğum Tarihi",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "18.18.1888",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    //-----------------------------------------------------------
                    Text(
                      "Adres",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Merkez - Adana",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ), //-----------------------------------------------------------
                    Text(
                      "Telefon Numarası",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "+905554443322",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ), //-----------------------------------------------------------
                    Text(
                      "E-Posta Adresi",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Deneme_3131@costurdum.com",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ), //-----------------------------------------------------------
                    Text(
                      "Cinsiyet",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Erkek",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ), //-----------------------------------------------------------
                    Text(
                      "Askerlik Durumu",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Komando olarak yaptı",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    //-----------------------------------------------------------
                    Text(
                      "Engellilik Durumu",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color.fromRGBO(111, 111, 111, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Yok",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              //---------------Yetkinliklerim Kısmı-----------------------
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Yetkinliklerim",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              //ShowDialog Açılacak!
                            },
                            icon: const Icon(Icons.visibility_outlined))
                      ],
                    ),
                    const Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    const SkillsWidget(skill: "C dili ve Edebiyatı"),
                    const SkillsWidget(skill: "Dart dili ve Edebiyatı"),
                    const SkillsWidget(skill: "Python dili ve Edebiyatı"),
                    const SkillsWidget(
                        skill: "a dili ve aaaaaaaaaaaaaaaaaaaEdebiyadsadastı"),
                  ],
                ),
              ),
              //Yabancı Diller Kısmı-------------------------------------------------------------
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yabancı Diller",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    LanguageWidget(
                        language: "İngilizce",
                        languageLevel: "Temel Seviye (A1,A2)")
                  ],
                ),
              ),
              //----Sertifika Kısmı-------------------------------------------------------------
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sertifikalarım",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    DateAndContentWidget(
                      date: "1555",
                      content:
                          "bilmemne zımbırtı sertifikasdsadsadadassdasdsaasdasdı",
                    )
                  ],
                ),
                //Profesyonel iş deneyimi kısmı-------------------------------------------------------
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profesyonel İş Deneyimi",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    DateAndContentWidget(
                      date: "Ağustos 2022 - Ekim 2055",
                      content: "yaprak kürek holding genel müdür",
                    )
                  ],
                ),
              ),
              //Eğitim Hayatımm---------------------------------
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eğitim Hayatım",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      thickness: 1,
                      endIndent: 10,
                    ),
                    DateAndContentWidget(
                      date: "Ağustos 2016 - Ekim 2055",
                      content:
                          "Diyarbakır Üniversitesi Mayın döşeme ve patlatma fakultesi",
                    )
                  ],
                ),
              ),
              //-->
            ],
          ),
        ),
      )),
    );
  }
}





// Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 padding: const EdgeInsets.all(15),
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Başlık",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     Divider(
//                       color: Color.fromRGBO(129, 129, 129, 1),
//                       thickness: 1,
//                       endIndent: 10,
//                     ),
//                   ],
//                 ),
//               ),
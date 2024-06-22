import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_date_and_content_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_language_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_skills_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class ProfilDetails extends StatelessWidget {
  const ProfilDetails({super.key});

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
                        //İsim Ve Soyisim Kısmı
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(Assets.imagesMhProfil),
                                      radius: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ad Soyad",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                        Text(
                                          "Muhammed Hocaoglu",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Text(
                                              "https://github.com/Muhammedhcgl1",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      11, 87, 208, 1)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundImage:
                                            AssetImage(Assets.imageInstagram),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                          AssetImage(Assets.imageLinkedin),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        //TODO:Profil düzenleme ekranının routu verilecek!
                                        Navigator.of(context).pushNamed(
                                            AppRouteNames.profileScreenRoute);
                                      },
                                      child: Icon(
                                        Icons.edit_square,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(Icons.share_outlined,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hakkımda",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "hakkımda ıvır zıvır asdas sad as asdasdasd  asdasdasdasd asdasdasdas  dasdasdasd  dasdasddas  dasdasdasd asdasdad dsada dasdasda dasda",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Kişisel Bilgiler
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kişisel Bilgiler",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              Text(
                                "Doğum Tarihi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "18.18.1888",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              //-----------------------------------------------------------
                              Text(
                                "Adres",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Merkez - Adana",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ), //-----------------------------------------------------------
                              Text(
                                "Telefon Numarası",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "+905554443322",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ), //-----------------------------------------------------------
                              Text(
                                "E-Posta Adresi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Deneme_3131@costurdum.com",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ), //-----------------------------------------------------------
                              Text(
                                "Cinsiyet",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Erkek",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ), //-----------------------------------------------------------
                              Text(
                                "Askerlik Durumu",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Komando olarak yaptı",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ),
                              //-----------------------------------------------------------
                              Text(
                                "Engellilik Durumu",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Yok",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //---------------Yetkinliklerim Kısmı-----------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Yetkinliklerim",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      //ShowDialog Açılacak!
                                      //TODO:Armağan Kardeş Buraya Bütün yetkinliklerin açılacağı bir Popup yapacak!
                                    },
                                    icon: Icon(
                                      Icons.visibility_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              const SkillsWidget(skill: "C dili ve Edebiyatı"),
                              const SkillsWidget(
                                  skill: "Dart dili ve Edebiyatı"),
                              const SkillsWidget(
                                  skill: "Python dili ve Edebiyatı"),
                              const SkillsWidget(
                                  skill:
                                      "a dili ve aaaaaaaaaaaaaaaaaaaEdebiyadsadastı"),
                            ],
                          ),
                        ),
                        //Yabancı Diller Kısmı-------------------------------------------------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yabancı Diller",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              const LanguageWidget(
                                  language: "İngilizce",
                                  languageLevel: "Temel Seviye (A1,A2)")
                            ],
                          ),
                        ),
                        //----Sertifika Kısmı-------------------------------------------------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sertifikalarım",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              const DateAndContentWidget(
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profesyonel İş Deneyimi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              const DateAndContentWidget(
                                date: "Ağustos 2022 - Ekim 2055",
                                content: "yaprak kürek holding genel müdür",
                              )
                            ],
                          ),
                        ),
                        //Eğitim Hayatımm---------------------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Eğitim Hayatım",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                thickness: 1,
                                endIndent: 10,
                              ),
                              const DateAndContentWidget(
                                date: "Ağustos 2016 - Ekim 2055",
                                content:
                                    "Diyarbakır Üniversitesi Mayın döşeme ve patlatma fakultesi",
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
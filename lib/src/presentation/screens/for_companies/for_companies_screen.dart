import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/src/presentation/screens/for_companies/widgets/for_companies_card_content.dart';
import 'package:tobeto/src/presentation/screens/for_companies/widgets/for_companies_card.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';

import '../../../common/constants/assets.dart';

class ForCompaniesScreen extends StatefulWidget {
  const ForCompaniesScreen({super.key});

  @override
  State<ForCompaniesScreen> createState() => _ForCompaniesScreenState();
}

final controller = ScrollController();

class _ForCompaniesScreenState extends State<ForCompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: TBTAppBar(controller: controller),
        drawer: const TBTDrawer(),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 15),
                child: ShaderMask(
                  //yazıyı gradient yapmak için kullanıldı!!
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 55, 45, 85),
                        Color.fromARGB(255, 151, 86, 159),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Tobeto; yetenekleri keşfeder, geliştirir ve yeni işine hazırlar.',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.asset(Assets.imagesMainHomePage2),
                  ),
                ),
              ),
              const ForCompaniesCard(
                header: "Doğru yeteneğe ulaşmak için",
                content:
                    "Kurumların değişen yetenek ihtiyaçları için istihdama hazır adaylar yetiştirir.",
                color: Color.fromARGB(255, 97, 4, 190),
                cardContentList: [
                  ForCompaniesCardContent(
                    header: "DEĞERLENDİRME",
                    content:
                        "Değerlendirilmiş ve yetişmiş geniş yetenek havuzuna erişim olanağı ve ölçme, değerlendirme, seçme ve raporlama hizmeti.",
                  ),
                  ForCompaniesCardContent(
                    header: "BOOTCAMP",
                    content:
                        "Değerlendirilmiş ve yetişmiş geniş yetenek havuzuna erişim olanağı ve ölçme, değerlendirme, seçme ve raporlama hizmeti.",
                  ),
                  ForCompaniesCardContent(
                    header: "EŞLEŞTİRME",
                    content:
                        "Esnek, uzaktan, tam zamanlı iş gücü için doğru ve hızlı işe alım.",
                  ),
                ],
              ),
              const ForCompaniesCard(
                header: "Çalışanlarınız için Tobeto",
                content:
                    "Çalışanların ihtiyaçları doğrultusunda, mevcut becerilerini güncellemelerine veya yeni beceriler kazanmalarına destek olur.",
                color: Color.fromRGBO(29, 68, 153, 1),
                cardContentList: [
                  ForCompaniesCardContent(
                    header: "ÖLÇME ARAÇLARI",
                    content:
                        "Uzmanlaşmak için yeni beceriler kazanmak (reskill) veya yeni bir role başlamak (upskill) isteyen adaylar için, teknik ve yetkinlik ölçme araçları.",
                  ),
                  ForCompaniesCardContent(
                    header: "EĞİTİM",
                    content:
                        "Yeni uzmanlık becerileri ve yeni bir rol için gerekli yetkinlik kazınımı ihtiyaçlarına bağlı olarak açılan eğitimlere katılım ve kuruma özel sınıf açma olanakları.",
                  ),
                  ForCompaniesCardContent(
                    header: "GELİŞİM",
                    content:
                        "Kurumsal hedefler doğrultusunda mevcut yetenek gücünün gelişimi ve konumlandırılmasına destek.",
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                  border: GradientBoxBorder(
                    width: 5, //border kalınlığı
                    gradient: SweepGradient(
                      startAngle: 2.3561944902, //rad türünden 135 derece
                      endAngle: 5.4977871438, //rad türünden 315 derece
                      colors: [
                        Colors.transparent,
                        Color.fromRGBO(110, 37, 132, 1),
                        Colors.transparent,
                      ],
                      stops: [0.15, 0.5, 0.88], //renk dağılımını ayarlamak için
                      tileMode: TileMode.mirror, // simetrik yansıtmak için
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Kurumlara özel eğitim paketleri ve bootcamp programları için bizimle iletişime geçin",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TBTPurpleButton(
                      width: 150,
                      buttonText: "Bize ulaşın",
                      onPressed: () {},
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

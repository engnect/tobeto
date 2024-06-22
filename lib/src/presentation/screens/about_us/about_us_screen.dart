import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/abous_us_page_carousel.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/about_us_image_card.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/about_us_page_our_team_card.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/about_us_video_card.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/assets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
                delegate: SliverChildListDelegate([
              Column(
                children: [
                  const AboutUsVideoCard(),
                  const AboutUsImageCard(
                    photo: Assets.imagesBilgisayarMuh,
                    content:
                        "Yeni nesil mesleklerdeki yetenek açığının mevcut yüksek deneyim ve beceri beklentisinden uzaklaşıp yeteneği keşfederek ve onları en iyi versiyonlarına ulaştırarak çözülebileceğine inanıyoruz. Tobeto; yetenekleri potansiyellerine göre değerlendirir, onları en uygun alanlarda geliştirir ve değer yaratacak projelerle eşleştirir. YES (Yetiş-Eşleş-Sürdür) ilkesini benimseyen herkese Tobeto Ailesi'ne katılmaya davet ediyor.",
                  ),
                  const AboutUsImageCard(
                    photo: Assets.imagesYazilim,
                    content:
                        "Günümüzde meslek hayatında yer almak ve kariyerinde yükselmek için en önemli unsurların başında dijital beceri sahibi olmak geliyor. Bu ihtiyaçların tamamını karşılamak için içeriklerimizi Tobeto Platform’da birleştirdik.",
                  ),
                  const AboutUsImageCard(
                    photo: Assets.imagesMainHomePage1,
                    content:
                        "Öğrencilerin teoriyi anlamalarını önemsemekle beraber uygulamayı merkeze alan bir öğrenme yolculuğu sunuyoruz. Öğrenciyi sürekli gelişim, geri bildirim döngüsünde tutarak yetenek ve beceri kazanımını hızlandırıyoruz.",
                  ),
                  const AboutUsCarousel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                    ),
                    child: Text(
                      "EKİBİMİZ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  const AboutUsOurTeamCard(
                    teamPhoto: Assets.imagesElif,
                    teamName: "Elif Kılıç",
                    teamTitle: "Kurucu Direktör",
                  ),
                  const AboutUsOurTeamCard(
                    teamPhoto: Assets.imagesKader,
                    teamName: "Kader Yavuz",
                    teamTitle: "Eğitim ve Proje Koordinatörü",
                  ),
                  const AboutUsOurTeamCard(
                    teamPhoto: Assets.imagesPelin,
                    teamName: "Pelin Batır",
                    teamTitle: "İş Geliştirme Yöneticisi",
                  ),
                  const AboutUsOurTeamCard(
                    teamPhoto: Assets.imagesGurkan,
                    teamName: "Gürkan İlişen",
                    teamTitle: "Eğitim Teknolojileri ve platform Sorumlusu",
                  ),
                  const AboutUsOurTeamCard(
                    teamPhoto: Assets.imagesAli,
                    teamName: "Ali Seyhan",
                    teamTitle: "Operasyon Uzman Yardımcısı",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(90, 0, 0, 0), blurRadius: 10),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Ofisimiz",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 50),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Kavacık, Rüzgarlıbahçe Mah. Çampınarı Sok. No:4 Smart Plaza B Blok Kat:3 34805, Beykoz,İstanbul",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(90, 0, 0, 0), blurRadius: 10),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                child: Image.asset(Assets.imageFacebook),
                                onTap: () => _launchUrl(
                                    'https://www.facebook.com/tobetoplatform'),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                onTap: () => _launchUrl(
                                    'https://twitter.com/tobeto_platform'),
                                child: Image.asset(Assets.imageX),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                onTap: () => _launchUrl(
                                    'https://www.linkedin.com/company/tobeto/'),
                                child: Image.asset(Assets.imageLinkedin),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                onTap: () => _launchUrl(
                                    'https://www.instagram.com/tobeto_official/'),
                                child: Image.asset(Assets.imageInstagram),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]))
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(a) async {
  if (!await launchUrl(Uri.parse(a), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch');
  }
}

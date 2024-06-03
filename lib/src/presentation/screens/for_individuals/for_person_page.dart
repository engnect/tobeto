import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/for_individuals/widgets/for_person_image_card.dart';
import 'package:tobeto/src/presentation/screens/for_individuals/widgets/for_person_page_text.dart';
import 'package:tobeto/src/presentation/screens/for_individuals/widgets/for_person_sector_card.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';

import '../../../common/constants/assets.dart';

class ForIndividualsScreen extends StatefulWidget {
  const ForIndividualsScreen({super.key});

  @override
  State<ForIndividualsScreen> createState() => _ForIndividualsScreenState();
}

final controller = ScrollController();

class _ForIndividualsScreenState extends State<ForIndividualsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: TbtAppBar(controller: controller),
        drawer: const TBTDrawer(),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(233, 232, 255, 1.00),
                ),
                child: Column(
                  children: [
                    const TextForPersonPage(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Assets.imageCodeSnippet),
                    )
                  ],
                ),
              ),
              const ForPersonImageCard(
                  photo: Assets.imageBirey1,
                  content:
                      "Uzmanlaşmak istediğin alanı seç, Tobeto Platform'da 'Eğitim Yolculuğu'na şimdi başla.\n\n   • Videolu içerikler\n   • Canlı dersler\n   • Mentör desteği\n   • Hibrit eğitim modeli",
                  title: "Eğitim Yolculuğu"),
              const ForPersonImageCard(
                  photo: Assets.imagesYazilim,
                  title: "Öğrenme Yolculuğu",
                  content:
                      'Deneyim sahibi olmak istediğin alanda "Öğrenme Yolculuğu’na" başla. Yazılım ekipleri ile çalış.\n\n   • Sektör projeleri\n   • Fasilitatör desteği\n   • Mentör desteği\n   • Hibrit eğitim modeli'),
              const ForPersonImageCard(
                  photo: Assets.imageBirey2,
                  title: "Kariyer Yolculuğu",
                  content:
                      '''Kariyer sahibi olmak istediğin alanda “Kariyer Yolculuğu'na” başla. Aradığın desteği Tobeto Platform'da yakala.\n\n   • Birebir mentör desteği\n   • CV hazırlama desteği\n   • Mülakat simülasyonu\n   • Kariyer buluşmaları'''),
              const SectorForPersonCard(),
            ],
          ),
        ),
      ),
    );
  }
}

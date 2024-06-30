import 'package:flutter/material.dart';

import '../../../common/export_common.dart';
import '../../widgets/export_widgets.dart';
import 'widgets/widgets.dart';

class ForIndividualsScreen extends StatelessWidget {
  const ForIndividualsScreen({super.key});

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
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Column(
                          children: [
                            const TextForPersonPage(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(Assets.imageCodeSnippet),
                            ),
                          ],
                        ),
                      ),
                      const ForIndividualsImageCard(
                        photo: Assets.imageBirey1,
                        content:
                            "Uzmanlaşmak istediğin alanı seç, Tobeto Platform'da 'Eğitim Yolculuğu'na şimdi başla.\n\n   • Videolu içerikler\n   • Canlı dersler\n   • Mentör desteği\n   • Hibrit eğitim modeli",
                        title: "Eğitim Yolculuğu",
                      ),
                      const ForIndividualsImageCard(
                          photo: Assets.imagesYazilim,
                          title: "Öğrenme Yolculuğu",
                          content:
                              'Deneyim sahibi olmak istediğin alanda "Öğrenme Yolculuğu’na" başla. Yazılım ekipleri ile çalış.\n\n   • Sektör projeleri\n   • Fasilitatör desteği\n   • Mentör desteği\n   • Hibrit eğitim modeli'),
                      const ForIndividualsImageCard(
                          photo: Assets.imageBirey2,
                          title: "Kariyer Yolculuğu",
                          content:
                              '''Kariyer sahibi olmak istediğin alanda “Kariyer Yolculuğu'na” başla. Aradığın desteği Tobeto Platform'da yakala.\n\n   • Birebir mentör desteği\n   • CV hazırlama desteği\n   • Mülakat simülasyonu\n   • Kariyer buluşmaları'''),
                      const SectorForPersonCard(),
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

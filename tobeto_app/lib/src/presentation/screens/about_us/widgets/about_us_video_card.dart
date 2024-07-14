import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/about_us_page_text.dart';
import 'package:tobeto/src/presentation/screens/about_us/widgets/about_us_video.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/constants/assets.dart';

class AboutUsVideoCard extends StatelessWidget {
  const AboutUsVideoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 5), //Ekran ile card arasında ki mesafe için
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(90),
        ),
        border: const GradientBoxBorder(
          width: 5, //border kalınlığı
          gradient: SweepGradient(
            startAngle: 2.3561944902, //rad türünden 135 derece
            endAngle: 5.4977871438, //rad türünden 315 derece
            colors: [
              Colors.transparent,
              Color.fromRGBO(110, 37, 132, 1),
              Colors.transparent,
            ],
            stops: [0.12, 0.5, 0.88], //renk dağılımını ayarlamak için
            tileMode: TileMode.mirror, // simetrik yansıtmak için
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(Assets.imagesTbtLogoT),
                const AboutUsText(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const TBTVideo(
                  dataSourceType: DataSourceType.asset,
                  url: Assets.aboutusvideo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

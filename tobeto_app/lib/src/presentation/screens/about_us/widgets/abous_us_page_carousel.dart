import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AboutUsCarousel extends StatefulWidget {
  const AboutUsCarousel({super.key});

  @override
  State<AboutUsCarousel> createState() => _AboutUsCarouselState();
}

class _AboutUsCarouselState extends State<AboutUsCarousel> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ), //Ekran ile card arasında ki mesafe için
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
            Text(
              textAlign: TextAlign.center,
              "TOBETO FARKI \n NEDİR?",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            CarouselSlider(
              carouselController: _controller,
              items: [
                Text(
                  textAlign: TextAlign.center,
                  "Zengin Eğitim Kütüphanesi",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  "Çeşitlendirilmiş değerlendirme araçlarıyla gelişim alanlarını tanıma",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24),
                ),
                Text(
                  "Online ve canlı derslerle hibrit yaklaşım",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24),
                ),
                Text(
                  "Alanında uzman eğitmenlerle canlı dersler",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24),
                ),
                Text(
                  "Fark yaratan bir gelişim süreci",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24),
                ),
                Text(
                  "Mesleki eğitimlerin yanı sıra kişisel ve profesyonel gelişim imkanı ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24),
                ),
              ],
              options: CarouselOptions(
                  height: 300,
                  scrollDirection: Axis.vertical,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  autoPlayCurve: Curves.easeIn,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            )
          ],
        ),
      ),
    );
  }
}

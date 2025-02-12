import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/src/common/constants/assets.dart';

import '../../../widgets/tbt_purple_button.dart';

class HomeScreenGif extends StatelessWidget {
  const HomeScreenGif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
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
            stops: [0.15, 0.5, 0.88],
            tileMode: TileMode.mirror,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(55),
              ),
              child: Image.asset(
                Assets.gifSpiderSlide,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                'Tobeto "İşte Başarı Modeli"mizi Keşfet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Text(
                "Üyelerimize ücretsiz sunduğumuz, iş bulma ve işte başarılı olma sürecinde gerekli 80 tane davranış ifadesinden oluşan Tobeto 'İşte Başarı Modeli' ile, profesyonellik yetkinliklerini ölç, raporunu gör.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TBTPurpleButton(
                width: 200,
                buttonText: "Hemen Başla",
                onPressed: () {}, // Giriş ekranına yönlendirme yapılacak!
              ),
            ),
          ],
        ),
      ),
    );
  }
}

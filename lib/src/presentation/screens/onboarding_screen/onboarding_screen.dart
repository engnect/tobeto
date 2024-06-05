import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tobeto/src/presentation/screens/home/home_screen.dart';
import 'package:tobeto/src/presentation/screens/onboarding_screen/app_styles.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        controlsMargin: const EdgeInsets.all(35),
        next: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppStyles.primaryColor,
        ),
        showSkipButton: true,
        skip: const Icon(
          Icons.keyboard_double_arrow_right_rounded,
          color: AppStyles.primaryColor,
        ),
        done: const Icon(
          Icons.check,
          color: AppStyles.primaryColor,
        ),
        onDone: () {
          gotoHomepage(context);
        },
        pages: [
          PageViewModel(
            decoration: AppStyles.pageDecoration,
            title: "TOBETO'ya Hoş Geldin!",
            body: "Hayalindeki teknoloji kariyerini TOBETO ile başlat",
            image: Image.asset(
              "assets/images/pc.png",
            ),
          ),
          PageViewModel(
            decoration: AppStyles.pageDecoration,
            title: "TÜRKİYE'DE BİR İLK:SOSYAL ETKİ TAHVİLİ",
            body: '"İstanbul Kodluyor: Yazılım, Eğitim ve İstihdam Projesi"',
            image: Image.asset("assets/images/code1.png"),
          ),
          PageViewModel(
            decoration: AppStyles.pageDecoration,
            title: "Kodlama Öğrenme Yolculuğuna Sen de Davetlisin",
            body:
                "Tobeto eğitimlerine katıl, sen de harekete geç, iş hayatında yerini al",
            image: Image.asset(
              width: 360,
              height: 360,
              "assets/images/lesson1.png",
            ),
          )
        ],
      ),
    );
  }
}

void gotoHomepage(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const HomeScreen()));
}

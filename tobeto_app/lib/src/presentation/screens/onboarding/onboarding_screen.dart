import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/common/theme/onboarding_screen_styles.dart';
import '../../../common/constants/assets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          controlsMargin: const EdgeInsets.all(35),
          next: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: OnBoardingScreenStyles.primaryColor,
          ),
          showSkipButton: true,
          skip: const Icon(
            Icons.keyboard_double_arrow_right_rounded,
            color: OnBoardingScreenStyles.primaryColor,
          ),
          done: const Icon(
            Icons.check,
            color: OnBoardingScreenStyles.primaryColor,
          ),
          onDone: () async {
            context.read<OnboardingCubit>().completeOnboarding();
            Navigator.of(context).pushReplacementNamed(AppRouteNames.homeRoute);
          },
          pages: [
            PageViewModel(
              decoration: OnBoardingScreenStyles.pageDecoration,
              title: "TOBETO'ya Hoş Geldin!",
              body: "Hayalindeki teknoloji kariyerini TOBETO ile başlat",
              image: Image.asset(
                Assets.imagePc,
              ),
            ),
            PageViewModel(
              decoration: OnBoardingScreenStyles.pageDecoration,
              title: "TÜRKİYE'DE BİR İLK:SOSYAL ETKİ TAHVİLİ",
              body: '"İstanbul Kodluyor: Yazılım, Eğitim ve İstihdam Projesi"',
              image: Image.asset(
                Assets.imageCode,
              ),
            ),
            PageViewModel(
              decoration: OnBoardingScreenStyles.pageDecoration,
              title: "Kodlama Öğrenme Yolculuğuna Sen de Davetlisin",
              body:
                  "Tobeto eğitimlerine katıl, sen de harekete geç, iş hayatında yerini al",
              image: Image.asset(
                width: 360,
                height: 360,
                Assets.imageLesson,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

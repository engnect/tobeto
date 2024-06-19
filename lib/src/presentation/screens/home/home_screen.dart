import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/data/datasource/avatar_fake_data.dart';
import 'package:tobeto/src/models/avatar_model.dart';
import 'package:tobeto/src/presentation/screens/home/widgets/animated_avatar.dart';
import 'package:tobeto/src/presentation/screens/home/widgets/info_card.dart';
import 'package:tobeto/src/presentation/screens/home/widgets/gif_card.dart';
import 'package:tobeto/src/presentation/screens/home/widgets/custom_text.dart';
import 'package:tobeto/src/presentation/screens/home/widgets/student_comment.dart';

import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import '../../../common/constants/assets.dart';
import 'widgets/carousel_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _carouselController = CarouselController();

  AvatarModel _selected = data[0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            CarouselSlider(
                              carouselController: _carouselController,
                              items: [
                                CarouselCard(
                                  header:
                                      "Hayalindeki teknoloji kariyerini Tobeto ile\n başlat",
                                  content:
                                      "Tobeto eğitimlerine katıl, sen de harekete geç, iş hayatında yerini\n al.",
                                  image:
                                      Image.asset(Assets.imagesMainHomePage1),
                                ),
                                CarouselCard(
                                  header: "Tobeto Platform",
                                  content:
                                      "Eğitim ve istihdam arasında köprü görevi görür.\n \n Eğitim, değerlendirme, istihdam süreçlerinin tek yerden yönetilebileceği dijital platform olarak hem bireylere hem kurumlara hizmet eder.",
                                  image:
                                      Image.asset(Assets.imagesMainHomePage2),
                                )
                              ],
                              options: CarouselOptions(
                                height: 575,
                                enlargeFactor: 0.5,
                                enlargeCenterPage: true,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _carouselController.previousPage();
                                  },
                                  child: const Icon(
                                    Icons.navigate_before,
                                    size: 50,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _carouselController.nextPage();
                                  },
                                  child: const Icon(
                                    Icons.navigate_next,
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TBTCustomText(),
                      ),
                      const TBTInfoCard(
                        icon: Icon(Icons.abc),
                        content: "Asenkron Eğitim İçeriği",
                        count: "8,000",
                        r: 110,
                        b: 137,
                        g: 32,
                      ),
                      const TBTInfoCard(
                        content: "Saat Canlı Ders",
                        count: "1,000",
                        icon: Icon(Icons.access_time),
                        r: 153,
                        g: 51,
                        b: 255,
                      ),
                      const TBTInfoCard(
                        content: "Öğrenci",
                        count: "17,600",
                        icon: Icon(Icons.person),
                        r: 44,
                        g: 102,
                        b: 230,
                      ),
                      const HomeScreenGif(),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                        child: Text(
                          "Öğrenci Görüşleri",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 20),
                        child: Text(
                          "Tobeto'yu öğrencilerimizin gözünden keşfedin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: data
                            .map(
                              (e) => AnimatedAvatar(
                                onTab: () {
                                  setState(() {
                                    _selected = e;
                                  });
                                },
                                model: e,
                              ),
                            )
                            .toList(),
                      ),
                      StudentCommentCard(
                        model: _selected,
                      ),
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

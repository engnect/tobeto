import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/extract_home_widgets.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import '../../../common/constants/assets.dart';

class PlatformScreen extends StatefulWidget {
  const PlatformScreen({super.key});

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

final controller = ScrollController();

class _PlatformScreenState extends State<PlatformScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Toplam sekme sayısı
      child: Scaffold(
        appBar: TbtAppBar(controller: controller),
        drawer: const TBTDrawer(),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "TOBETO",
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 153, 51, 255),
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "'ya Hoş Geldin",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 77, 77, 77),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "İsim!",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 77, 77, 77),
                    ),
                  ),
                ),
                const Text(
                  "Yeni nesil öğrenme deneyimi ile Tobeto kariyer yolculuğunda senin yanında!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20), // Boşluk ekledik
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: Image.asset(
                                Assets.imagesIkLogo,
                                width: 200,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                              child: Text(
                                "Ücretsiz eğitimlerle, \n geleceğin mesleklerinde \n sen  de yerini al.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Aradığın '),
                                  TextSpan(
                                    text: '"',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Color.fromARGB(255, 0, 210, 155),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'İş',
                                  ),
                                  TextSpan(
                                    text: '" ',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Color.fromARGB(255, 0, 210, 155),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  TextSpan(text: 'Burada!'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'Duyurular'),
                          Tab(text: 'Anketler'),
                          Tab(text: 'Sınavlar'),
                        ],
                      ),
                      const SizedBox(
                        height: 250, // TabBarView'ın yüksekliği
                        child: TabBarView(
                          children: [
                            // Duyurular içeriği
                            Center(
                              child: Text('Duyurular İçeriği'),
                            ),
                            // Anketler içeriği
                            Center(
                              child: Text('Anketler İçeriği'),
                            ),
                            // Sınavlar içeriği
                            Center(
                              child: Text('Sınavlar İçeriği'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TBTPurpleCard(
                  cardText: 'Profilini Oluştur',
                  onPressed: () {},
                ),

                TBTPurpleCard(
                  cardText: "Kendini değerlendir",
                  onPressed: () {},
                ),
                //

                // widget
                TBTPurpleCard(
                  cardText: 'Öğrenmeye Başla!',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

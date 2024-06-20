import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/models/announcement_model.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/end_drawer.dart';
import 'package:tobeto/src/presentation/screens/platform/tabs/announcement_card.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/purple_card.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import '../../../../common/constants/assets.dart';

class PlatformTab extends StatelessWidget {
  const PlatformTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3, // Toplam sekme sayısı
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              AuthRepository().signOutUser();
            },
            child: const Icon(Icons.add),
          ),
          drawer: const TBTDrawer(),
          endDrawer: const TBTEndDrawer(),
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
          body: CustomScrollView(
            slivers: [
              const TBTSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                              fontWeight: FontWeight.w500,
                            ),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 30),
                                        child: Image.asset(
                                          Assets.imagesIkLogo,
                                          width: 200,
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 10, 25, 10),
                                        child: Text(
                                          "Ücretsiz eğitimlerle, \n geleceğin mesleklerinde \n sen  de yerini al.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                                color: Color.fromARGB(
                                                    255, 0, 210, 155),
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
                                                color: Color.fromARGB(
                                                    255, 0, 210, 155),
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
                                SizedBox(
                                  height: 250, // TabBarView'ın yüksekliği
                                  child: TabBarView(
                                    children: [
                                      // Duyurular içeriği
                                      SizedBox(
                                        height: 200,
                                        width: 300,
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection(FirebaseConstants
                                                  .announcementsCollection)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              return ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      snapshot
                                                          .data!.docs[index];

                                                  AnnouncementModel
                                                      announcementModel =
                                                      AnnouncementModel.fromMap(
                                                          documentSnapshot
                                                                  .data()
                                                              as Map<String,
                                                                  dynamic>);

                                                  return AnnouncementCard(
                                                      announcementModel:
                                                          announcementModel);
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      // Anketler içeriği
                                      const Center(
                                        child: Text('Anketler İçeriği'),
                                      ),
                                      // Sınavlar içeriği
                                      const Center(
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

                          TBTPurpleCard(
                            cardText: 'Öğrenmeye Başla!',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

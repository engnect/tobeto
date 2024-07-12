import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class PlatformTabScreen extends StatefulWidget {
  const PlatformTabScreen({super.key});

  @override
  State<PlatformTabScreen> createState() => _PlatformTabScreenState();
}

class _PlatformTabScreenState extends State<PlatformTabScreen> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    userModel = await UserRepository().getCurrentUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Toplam sekme sayısı
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "${userModel?.userName ?? "İsim"} ${userModel?.userSurname ?? "Soyisim"}!",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                        ),
                        Text(
                          "Yeni nesil öğrenme deneyimi ile Tobeto kariyer yolculuğunda senin yanında!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 20), // Boşluk ekledik
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              color: Theme.of(context).colorScheme.background),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 10, 25, 10),
                                      child: Text(
                                        "Ücretsiz eğitimlerle, \n geleceğin mesleklerinde \n sen  de yerini al.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w800,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        children: const <TextSpan>[
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
                                indicatorColor:
                                    Color.fromARGB(255, 153, 51, 255),
                                dividerColor: Color.fromARGB(255, 153, 51, 255),
                                unselectedLabelColor:
                                    Color.fromARGB(255, 153, 51, 255),
                                labelColor: Color.fromARGB(255, 153, 51, 255),
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
                                        stream: FirebaseService()
                                            .firebaseFirestore
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
                                                    snapshot.data!.docs[index];

                                                AnnouncementModel
                                                    announcementModel =
                                                    AnnouncementModel.fromMap(
                                                        documentSnapshot.data()
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
                                    Center(
                                      child: Text(
                                        '🛠️ Yapım Aşamasında 🚧',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    // Sınavlar içeriği
                                    Center(
                                      child: Text(
                                        '🛠️ Yapım Aşamasında 🚧',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
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
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
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

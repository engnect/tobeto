import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tobeto/src/common/constants/assets.dart';

class StudentsEdit extends StatefulWidget {
  const StudentsEdit({super.key});

  @override
  State<StudentsEdit> createState() => _StudentsEditState();
}

class _StudentsEditState extends State<StudentsEdit> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, // tab sayısı
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Öğrencileri düzenle"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(Assets.imagesDefaultAvatar),
              radius: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Rastgeleisim Soyisim",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                textAlign: TextAlign.left,
                "Rastgele sınıf",
                softWrap: true,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    color: Color.fromRGBO(135, 135, 135, 1)),
              ),
            ),
            const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.work)),
                Tab(icon: Icon(Icons.school)),
                Tab(icon: Icon(Icons.lightbulb)),
                Tab(icon: Icon(Icons.assignment)),
                Tab(icon: Icon(Icons.account_circle)),
                Tab(icon: Icon(Icons.language)),
              ],
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    color: Colors.amber,
                    child: TabBarView(
                      children: [
                        const Center(child: Text('111')),
                        const Center(child: Text('222')),
                        const Center(child: Text('333')),
                        const Center(child: Text('444')),
                        const Center(child: Text('555')),
                        const Center(child: Text('666')),
                        SingleChildScrollView(
                          child: Center(
                              child: Container(
                            height: 900,
                            width: 200,
                            color: Colors.blueAccent,
                            child: const Text(
                                "sadad\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA\nA"),
                          )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

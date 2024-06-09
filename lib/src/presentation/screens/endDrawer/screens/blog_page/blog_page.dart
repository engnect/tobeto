import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/in_the_press_admin/in_the_press_fake_data.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/in_the_press_admin/in_the_press_modes.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

/*




!!!!!!!!!!!!!!!!!!!!!!!!
Önemli Basında biz Sayfası ile Blog Sayfası aynı model üzerinden firebase e
Göndereceğimiz için bu sayfada Basında biz Model ve Verileri Kullanılmıştır.
İlgili Arkadaşların Dikkatine !!!!!!!!!!!!!!



 */

class BlogPageAdmin extends StatefulWidget {
  const BlogPageAdmin({
    super.key,
  });

  @override
  State<BlogPageAdmin> createState() => _BlogPageAdminState();
}

class _BlogPageAdminState extends State<BlogPageAdmin> {
  List<InThePressModel> data = fakeData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blog"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Blogları Düzenle",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.7), blurRadius: 20)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: TBTPurpleButton(
                    buttonText: "Yeni İçerik Ekle",
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(
                          AppRouteNames.inThePressAddEditScreenRoute);
                    },
                  ),
                ),
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 200,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.6,
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                print("Sile tıklandı");
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Sil',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                print("Düzenleye tıklandı");
                              },
                              backgroundColor: const Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Düzenle',
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 2,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(data[index].image),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          data[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          data[index].date,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  135, 135, 135, 1)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          data[index].content,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  135, 135, 135, 1)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

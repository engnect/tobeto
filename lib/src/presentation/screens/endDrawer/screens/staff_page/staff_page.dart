import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/router/app_router.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/staff_page/staff_fake_data.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/staff_page/staff_model.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({
    super.key,
  });

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<StaffModel> data = staffFakeData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kadro"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Kadro Düzenle",
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
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.7), blurRadius: 20)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TBTPurpleButton(
                      buttonText: "Yeni Personel Ekle",
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.staffAddEditScreenRoute);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        200,
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
                                  backgroundImage:
                                      AssetImage(data[index].avatar),
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            data[index].name,
                                            style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            data[index].job,
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
      ),
    ));
  }
}



//  ListTile(
//                           style: ListTileStyle.drawer,
//                           title: Text(
//                             data[index].name,
//                           ),
//                           subtitle: Text(
//                             data[index].job,
//                             style: const TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 16,
//                                 color: Color.fromRGBO(135, 135, 135, 1)),
//                           ),
//                           leading: CircleAvatar(
//                             radius: 40,
//                             backgroundImage: AssetImage(data[index].avatar),
//                           ),
//                         ),
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/domain/repositories/announcement_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/announcement_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:uuid/uuid.dart';

class AdminAnnouncementsScreen extends StatefulWidget {
  const AdminAnnouncementsScreen({
    super.key,
  });

  @override
  State<AdminAnnouncementsScreen> createState() =>
      _AdminAnnouncementsScreenState();
}

class _AdminAnnouncementsScreenState extends State<AdminAnnouncementsScreen> {
  bool isSelect = false;
  DateTime? selectedDate;
  final ScrollController _controller = ScrollController();
  final TextEditingController _announcementTitleController =
      TextEditingController();
  final TextEditingController _announcementContentController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _announcementTitleController.dispose();
    _announcementContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: _controller),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Duyurular",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TBTPurpleButton(
                  buttonText: "Yeni Duyuru Yap",
                  onPressed: () {
                    setState(() {
                      isSelect = !isSelect;
                    });
                  },
                ),
                TBTAnimatedContainer(
                  isExpanded: isSelect,
                  height: 275,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TBTInputField(
                        hintText: 'Duyuru Başlığı',
                        controller: _announcementTitleController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline,
                      ),
                      TBTInputField(
                        hintText: 'Duyuru İçeriği',
                        controller: _announcementContentController,
                        onSaved: (p0) {},
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      TBTPurpleButton(
                        buttonText: 'Duyuruyu Ekle',
                        onPressed: () async {
                          UserModel? currentUser =
                              await UserRepository().getCurrentUser();

                          AnnouncementModel announcementModel =
                              AnnouncementModel(
                            announcementId: const Uuid().v1(),
                            userId: currentUser!.userId,
                            announcementTitle:
                                _announcementTitleController.text,
                            announcementContent:
                                _announcementContentController.text,
                            announcementDate: DateTime.now(),
                          );

                          String result = await AnnouncementRepository()
                              .addOrUpdateAnnouncement(
                                  announcementModel: announcementModel);

                          print(result);
                        },
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseConstants.announcementsCollection)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];

                          AnnouncementModel announcementModel =
                              AnnouncementModel.fromMap(documentSnapshot.data()
                                  as Map<String, dynamic>);
                          return ListTile(
                            title: Text(announcementModel.announcementTitle),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(announcementModel.announcementDate),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

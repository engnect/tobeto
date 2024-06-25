import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/announcement_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/announcement_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_input_field.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_admin_sliver_app_bar.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
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

  final TextEditingController _announcementTitleController =
      TextEditingController();
  final TextEditingController _announcementContentController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _announcementTitleController.dispose();
    _announcementContentController.dispose();
  }

  _addNewAnnouncement({
    required String announcementTitle,
    required String announcementContent,
    required BuildContext context,
  }) async {
    UserModel? currentUser = await UserRepository().getCurrentUser();

    AnnouncementModel announcementModel = AnnouncementModel(
      announcementId: const Uuid().v1(),
      userId: currentUser!.userId,
      announcementTitle: announcementTitle,
      announcementContent: announcementContent,
      announcementDate: DateTime.now(),
    );

    String result = await AnnouncementRepository()
        .addOrUpdateAnnouncement(announcementModel: announcementModel);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  _deleteAnnouncement({
    required AnnouncementModel announcementModel,
    required BuildContext context,
  }) async {
    String result = await AnnouncementRepository()
        .deleteAnnouncement(announcementModel: announcementModel);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const TBTAdminSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Duyurular",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        TBTAnimatedContainer(
                          infoText: 'Yeni Duyuru Yap!',
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
                                onPressed: () {
                                  _addNewAnnouncement(
                                    announcementTitle:
                                        _announcementTitleController.text,
                                    announcementContent:
                                        _announcementContentController.text,
                                    context: context,
                                  );

                                  _announcementContentController.clear();
                                  _announcementTitleController.clear();
                                },
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  FirebaseConstants.announcementsCollection)
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
                                      AnnouncementModel.fromMap(documentSnapshot
                                          .data() as Map<String, dynamic>);
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.55,
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) => _deleteAnnouncement(
                                            announcementModel:
                                                announcementModel,
                                            context: context,
                                          ),
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Sil',
                                        ),
                                        SlidableAction(
                                          onPressed: (_) {},
                                          backgroundColor:
                                              const Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Düzenle',
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        announcementModel.announcementTitle,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            announcementModel.announcementDate),
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

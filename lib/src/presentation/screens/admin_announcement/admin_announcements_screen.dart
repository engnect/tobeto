import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import 'package:uuid/uuid.dart';
import '../../../common/export_common.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

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

  void _addNewAnnouncement({
    required String announcementTitle,
    required String announcementContent,
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

    Utilities.showToast(toastMessage: result);
  }

  void _showEditAnnouncementDialog({
    required AnnouncementModel announcementModel,
    required BuildContext context,
  }) {
    final TextEditingController editTitleController =
        TextEditingController(text: announcementModel.announcementTitle);
    final TextEditingController editDescriptionController =
        TextEditingController(text: announcementModel.announcementContent);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Duyuruyu Düzenle'),
        content: StatefulBuilder(
          builder: (ctx, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TBTInputField(
                  hintText: 'Duyuru Başlığı',
                  controller: editTitleController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                ),
                TBTInputField(
                  hintText: 'Duyuru Açıklaması',
                  controller: editDescriptionController,
                  maxLines: 5,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              AnnouncementModel updatedAnnouncement =
                  announcementModel.copyWith(
                announcementTitle: editTitleController.text,
                announcementContent: editDescriptionController.text,
              );
              String result = await AnnouncementRepository()
                  .addOrUpdateAnnouncement(
                      announcementModel: updatedAnnouncement);
              if (!context.mounted) return;

              Utilities.showToast(toastMessage: result);
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccouncementDialog({
    required AnnouncementModel announcementModel,
    required BuildContext context,
  }) async {
    PanaraConfirmDialog.showAnimatedFade(
      context,
      title: 'Dikkat!',
      message: 'İçeriği KALICI olarak silmek istediğinize eminmisiniz?',
      confirmButtonText: 'Sil!',
      cancelButtonText: 'İptal!',
      onTapConfirm: () async {
        String result = await AnnouncementRepository()
            .deleteAnnouncement(announcementModel: announcementModel);

        Utilities.showToast(toastMessage: result);
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
      onTapCancel: () {
        Navigator.of(context).pop();
      },
      panaraDialogType: PanaraDialogType.error,
    );
  }

  void _showAccouncementDetailsDialog({
    required AnnouncementModel announcementModel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(announcementModel.announcementTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Duyuru ID: ${announcementModel.announcementId}'),
              Text('Kullanıcı ID: ${announcementModel.userId}'),
              Text('Duyuru İçeriği: ${announcementModel.announcementContent}'),
              Text(
                  'Duyuru Tarihi: ${DateFormat('dd/MM/yyyy').format(announcementModel.announcementDate)}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
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
                    child: TBTAnimatedContainer(
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
                              );

                              _announcementContentController.clear();
                              _announcementTitleController.clear();
                            },
                          ),
                        ],
                      ),
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
                                AnnouncementModel.fromMap(documentSnapshot
                                    .data() as Map<String, dynamic>);

                            return TBTSlideableListTile(
                              imgUrl: null,
                              title: announcementModel.announcementTitle,
                              subtitle: DateFormat('dd/MM/yyyy')
                                  .format(announcementModel.announcementDate),
                              deleteOnPressed: (p0) {
                                _showDeleteAccouncementDialog(
                                  announcementModel: announcementModel,
                                  context: context,
                                );
                              },
                              editOnPressed: (p0) {
                                _showEditAnnouncementDialog(
                                  announcementModel: announcementModel,
                                  context: context,
                                );
                              },
                              onTap: () {
                                _showAccouncementDetailsDialog(
                                    announcementModel: announcementModel);
                              },
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
    );
  }
}

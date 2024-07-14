import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import 'package:uuid/uuid.dart';
import '../../../common/export_common.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminEventScreen extends StatefulWidget {
  const AdminEventScreen({
    super.key,
  });

  @override
  State<AdminEventScreen> createState() => _AdminEventScreenState();
}

class _AdminEventScreenState extends State<AdminEventScreen> {
  DateTime? selectedDate;

  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _eventTitleController.dispose();
    _eventDescriptionController.dispose();
  }

  void _addEvent({
    required String eventTitle,
    required String eventDescription,
    required DateTime eventDate,
  }) async {
    UserModel? currentUser = await UserRepository().getCurrentUser();

    CalendarModel eventModel = CalendarModel(
      eventId: const Uuid().v1(),
      userId: currentUser!.userId,
      userNameAndSurname: '${currentUser.userName} ${currentUser.userSurname}',
      eventTitle: _eventTitleController.text,
      eventDescription: _eventDescriptionController.text,
      eventDate: selectedDate!,
    );

    String result =
        await CalendarRepository().addOrUpdateEvent(eventModel: eventModel);

    Utilities.showToast(toastMessage: result);
  }

  void _showEditEventDialog({
    required CalendarModel eventModel,
    required BuildContext context,
  }) {
    final TextEditingController editTitleController =
        TextEditingController(text: eventModel.eventTitle);
    final TextEditingController editDescriptionController =
        TextEditingController(text: eventModel.eventDescription);
    DateTime? editSelectedDate = eventModel.eventDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Etkinliği Düzenle'),
        content: StatefulBuilder(
          builder: (ctx, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TBTInputField(
                  hintText: 'Etkinlik Başlığı',
                  controller: editTitleController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                ),
                TBTInputField(
                  hintText: 'Etkinlik Açıklaması',
                  controller: editDescriptionController,
                  maxLines: 5,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () async {
                    editSelectedDate = await Utilities.datePicker(context);
                    setState(() {});
                  },
                  label: Text(
                    editSelectedDate == null
                        ? 'Tarih Seç'
                        : DateFormat('dd/MM/yyyy').format(editSelectedDate!),
                  ),
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
              CalendarModel updatedEvent = eventModel.copyWith(
                eventTitle: editTitleController.text,
                eventDescription: editDescriptionController.text,
                eventDate: editSelectedDate,
              );
              String result = await CalendarRepository()
                  .addOrUpdateEvent(eventModel: updatedEvent);
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

  void _showDeleteEventDialog({
    required CalendarModel calendarModel,
    required BuildContext context,
  }) async {
    PanaraConfirmDialog.showAnimatedFade(
      context,
      title: 'Dikkat!',
      message: 'İçeriği KALICI olarak silmek istediğinize eminmisiniz?',
      confirmButtonText: 'Sil!',
      cancelButtonText: 'İptal!',
      onTapConfirm: () async {
        String result =
            await CalendarRepository().deleteEvent(eventModel: calendarModel);

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

  void _showEventDetailsDialog({
    required CalendarModel eventModel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(eventModel.eventTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Etkinlik ID: ${eventModel.eventId}'),
              Text('Kullanıcı ID: ${eventModel.userId}'),
              Text('Kullanıcı Adı: ${eventModel.userNameAndSurname}'),
              Text('Etkinlik Açıklaması: ${eventModel.eventDescription}'),
              Text(
                  'Etkinlik Tarihi: ${DateFormat('dd/MM/yyyy').format(eventModel.eventDate)}'),
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
                      infoText: 'Yeni Etkinlik Ekle!',
                      height: 275,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TBTInputField(
                            hintText: 'Etkinlik Başlığı',
                            controller: _eventTitleController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                          ),
                          TBTInputField(
                            hintText: 'Etkinlik Açıklaması',
                            controller: _eventDescriptionController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.calendar_today_outlined),
                            onPressed: () async {
                              selectedDate =
                                  await Utilities.datePicker(context);

                              setState(() {});
                            },
                            label: Text(
                              selectedDate == null
                                  ? 'Tarih Seç'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(selectedDate!),
                            ),
                          ),
                          TBTPurpleButton(
                            buttonText: 'Etkinliği Ekle',
                            onPressed: () => _addEvent(
                              eventTitle: _eventTitleController.text,
                              eventDescription:
                                  _eventDescriptionController.text,
                              eventDate: selectedDate ?? DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseService()
                        .firebaseFirestore
                        .collection(FirebaseConstants.eventsCollection)
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

                            CalendarModel eventModel = CalendarModel.fromMap(
                                documentSnapshot.data()
                                    as Map<String, dynamic>);

                            return TBTSlideableListTile(
                              imgUrl: null,
                              title: eventModel.eventTitle,
                              subtitle: DateFormat('dd/MM/yyyy')
                                  .format(eventModel.eventDate),
                              deleteOnPressed: (p0) {
                                _showDeleteEventDialog(
                                    calendarModel: eventModel,
                                    context: context);
                              },
                              editOnPressed: (p0) {
                                _showEditEventDialog(
                                    eventModel: eventModel, context: context);
                              },
                              onTap: () {
                                _showEventDetailsDialog(eventModel: eventModel);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  bool isSelect = false;
  DateTime? selectedDate;
  final ScrollController _controller = ScrollController();
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _eventTitleController.dispose();
    _eventDescriptionController.dispose();
  }

  void addEvent(BuildContext context) async {
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

    if (!context.mounted) return;
    Utilities.showSnackBar(
      snackBarMessage: result,
      context: context,
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
                    child: Column(
                      children: [
                        TBTAnimatedContainer(
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
                                onPressed: () => addEvent(context),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.eventsCollection)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                controller: _controller,
                                primary: false,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];

                                  CalendarModel eventModel =
                                      CalendarModel.fromMap(documentSnapshot
                                          .data() as Map<String, dynamic>);
                                  return ListTile(
                                    title: Text(
                                      eventModel.eventTitle,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(eventModel.eventDate),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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

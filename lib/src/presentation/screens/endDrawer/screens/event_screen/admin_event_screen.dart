import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/domain/repositories/calendar_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/calendar_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';

import 'package:uuid/uuid.dart';

import '../../../../../common/constants/firebase_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              // appbar
              SliverAppBar(
                floating: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    Assets.imagesTobetoLogo,
                  ),
                ),
              ),

              // body
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Takvim Düzenle",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                                  icon:
                                      const Icon(Icons.calendar_today_outlined),
                                  onPressed: () async {
                                    selectedDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    );

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
                                  onPressed: () async {
                                    UserModel? currentUser =
                                        await UserRepository().getCurrentUser();

                                    EventModel eventModel = EventModel(
                                      eventId: const Uuid().v1(),
                                      userId: currentUser!.userId,
                                      eventTitle: _eventTitleController.text,
                                      eventDescription:
                                          _eventDescriptionController.text,
                                      eventDate: selectedDate!,
                                    );

                                    await CalendarRepository().addOrUpdateEvent(
                                        eventModel: eventModel);
                                  },
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

                                    EventModel eventModel = EventModel.fromMap(
                                        documentSnapshot.data()
                                            as Map<String, dynamic>);
                                    return ListTile(
                                      title: Text(eventModel.eventTitle),
                                      subtitle: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(eventModel.eventDate),
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
          )),
    );
  }
}

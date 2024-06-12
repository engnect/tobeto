import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/domain/repositories/calendar_repository.dart';
import 'package:tobeto/src/models/calendar_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

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
  final controller = ScrollController();
  DateTime? selectedDate;

  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: controller),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
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
                TBTPurpleButton(
                  buttonText: "Yeni Etkinlik Ekle",
                  onPressed: () {
                    setState(() {
                      isSelect = !isSelect;
                    });
                  },
                ),
                AnimatedContainer(
                  decoration: BoxDecoration(
                    borderRadius: isSelect
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                        : null,
                    border: Border(
                      bottom: BorderSide(
                        width: isSelect ? 7 : 0,
                        color: const Color.fromARGB(255, 153, 51, 255),
                      ),
                    ),
                  ),
                  height: isSelect ? 275 : 0,
                  duration: const Duration(seconds: 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TBTInputField(
                        hintText: 'Etkinlik Başlığı',
                        controller: eventTitleController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline,
                      ),
                      TBTInputField(
                        hintText: 'Etkinlik Açıklaması',
                        controller: eventDescriptionController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.multiline,
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.calendar_today_outlined),
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
                              : DateFormat('dd/MM/yyyy').format(selectedDate!),
                        ),
                      ),
                      TBTPurpleButton(
                        buttonText: 'Etkinliği Ekle',
                        onPressed: () async {
                          EventModel eventModel = EventModel(
                            eventId: 'eventId',
                            userId: '',
                            eventTitle: eventTitleController.text,
                            eventDescription: eventDescriptionController.text,
                            eventDate: selectedDate!,
                          );

                          await CalendarRepository()
                              .addEvent(eventModel: eventModel);
                        },
                      ),
                    ],
                  ),
                ),
                //
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 200,
                  child: StreamBuilder(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

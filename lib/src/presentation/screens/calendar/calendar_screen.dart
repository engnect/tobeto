import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/export_common.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';
import 'widgets/widgets.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<CalendarModel> events = [];
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<CalendarModel> _getEventsfromDay(DateTime date) {
    return events.where((event) => isSameDay(event.eventDate, date)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.eventsCollection)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            List<Map<String, dynamic>> documentData = snapshot
                                .data!.docs
                                .map((e) => e.data())
                                .toList();
                            events = [];
                            for (var i = 0; i < documentData.length; i++) {
                              events
                                  .add(CalendarModel.fromMap(documentData[i]));
                            }
                            return TableCalendar(
                              focusedDay: selectedDay,
                              firstDay: DateTime(2020),
                              lastDay: DateTime(2025),
                              calendarFormat: CalendarFormat.month,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              daysOfWeekVisible: true,
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                weekendStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              daysOfWeekHeight: 25,
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                  focusedDay = focusDay;
                                });
                              },
                              selectedDayPredicate: (DateTime date) {
                                return isSameDay(selectedDay, date);
                              },
                              eventLoader: _getEventsfromDay,
                              calendarStyle: CalendarStyle(
                                outsideTextStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                defaultTextStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                weekendTextStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                                isTodayHighlighted: true,
                                selectedDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                selectedTextStyle:
                                    const TextStyle(color: Colors.white),
                                todayDecoration: BoxDecoration(
                                  color: Colors.purpleAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                defaultDecoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                weekendDecoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                titleTextStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: _getEventsfromDay(selectedDay)
                              .map(
                                (CalendarModel calendarModel) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CalendarDetailsCard(
                                    calendarModel: calendarModel,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
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

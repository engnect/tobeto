import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';

import '../../models/calendar_model.dart';

class CalendarRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _events =>
      _firebaseFirestore.collection(FirebaseConstants.eventsCollection);

  Future<List<EventModel>> fetchEventsFromFirestore() async {
    List<EventModel> events = [];
    var querySnapshot = await _events.get();
    for (var doc in querySnapshot.docs) {
      events.add(EventModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return events;
  }

  Future<String> addEvent({
    required EventModel eventModel,
  }) async {
    String result = '';

    try {
      await _events.add(eventModel.toMap());
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> updateEvent({
    required EventModel eventModel,
  }) async {
    String result = '';

    try {
      await _events.doc(eventModel.eventId).set(eventModel);
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> deleteEvent({
    required EventModel eventModel,
  }) async {
    String result = '';

    try {
      await _events.doc(eventModel.eventId).delete();
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return result;
  }
}

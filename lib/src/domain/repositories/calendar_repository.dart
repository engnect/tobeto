import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';

import '../../models/calendar_model.dart';

class CalendarRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _events =>
      _firebaseFirestore.collection(FirebaseConstants.eventsCollection);

  Future<String> addOrUpdateEvent({
    required EventModel eventModel,
  }) async {
    String result = '';

    try {
      await _events.doc(eventModel.eventId).set(eventModel.toMap());
      result = 'success';
    } catch (error) {
      result = error.toString();
    }

    return Utilities.errorMessageChecker(result);
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

    return Utilities.errorMessageChecker(result);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import '../../common/export_common.dart';
import '../../models/export_models.dart';

class CalendarRepository {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseService().firebaseFirestore;

  CollectionReference get _events =>
      _firebaseFirestore.collection(FirebaseConstants.eventsCollection);

  Future<String> addOrUpdateEvent({
    required CalendarModel eventModel,
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
    required CalendarModel eventModel,
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

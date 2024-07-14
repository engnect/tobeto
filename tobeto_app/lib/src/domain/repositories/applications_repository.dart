import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import '../../common/export_common.dart';
import '../../models/export_models.dart';

class ApplicationsRepository {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseService().firebaseFirestore;

  CollectionReference get _applications =>
      _firebaseFirestore.collection(FirebaseConstants.applicationsCollection);

  Future<String> addOrUpdateApplication({
    required ApplicationModel applicationModel,
  }) async {
    String result = '';
    try {
      await _applications
          .doc(applicationModel.applicationId)
          .set(applicationModel.toMap());

      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteAnnouncement({
    required ApplicationModel applicationModel,
  }) async {
    String result = '';
    try {
      await _applications.doc(applicationModel.applicationId).delete();

      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return Utilities.errorMessageChecker(result);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/models/application_model.dart';

class ApplicationsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

    switch (result) {
      case 'success':
        return 'İşlem Başarılı';

      default:
        return 'Hata: $result';
    }
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

    switch (result) {
      case 'success':
        return 'İşlem Başarılı';

      default:
        return 'Hata: $result';
    }
  }
}

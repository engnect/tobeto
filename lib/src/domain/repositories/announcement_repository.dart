import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import '../../common/export_common.dart';
import '../../models/export_models.dart';

class AnnouncementRepository {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseService().firebaseFirestore;
  CollectionReference get _announcement =>
      _firebaseFirestore.collection(FirebaseConstants.announcementsCollection);

  Future<String> addOrUpdateAnnouncement({
    required AnnouncementModel announcementModel,
  }) async {
    String result = '';
    try {
      await _announcement
          .doc(announcementModel.announcementId)
          .set(announcementModel.toMap());

      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteAnnouncement({
    required AnnouncementModel announcementModel,
  }) async {
    String result = '';
    try {
      await _announcement.doc(announcementModel.announcementId).delete();

      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }
}

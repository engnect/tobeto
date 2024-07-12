import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import '../../common/export_common.dart';
import '../../models/export_models.dart';

class ContactFromRepository {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseService().firebaseFirestore;

  CollectionReference get _contactForms =>
      _firebaseFirestore.collection(FirebaseConstants.contactFormsCollection);

  Future<String> sendOrUpdateForm(ContactFormModel contactFormModel) async {
    String result = '';
    try {
      await _contactForms
          .doc(contactFormModel.contactFormId)
          .set(contactFormModel.toMap());
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteForm(String contactFormId) async {
    String result = '';
    try {
      await _contactForms.doc(contactFormId).delete();
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }
}

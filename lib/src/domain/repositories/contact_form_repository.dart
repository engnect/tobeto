import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/models/contact_form_model.dart';

class ContactFromRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _contactForms =>
      _firebaseFirestore.collection(FirebaseConstants.contactFormsCollection);

  Future<String> sendOrUpdateForm(ContactFormModel contactFormModel) async {
    String result = '';
    try {
      await _contactForms
          .doc(contactFormModel.contactFormId)
          .set(contactFormModel.toMap());
      result = 'success';
    } catch (_) {
      result = 'failure';
    }
    return result;
  }

  Future<String> deleteForm(String contactFormId) async {
    String result = '';
    try {
      await _contactForms.doc(contactFormId).delete();
      result = 'success';
    } catch (_) {
      result = 'failure';
    }
    return result;
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../common/export_common.dart';
import '../../models/export_models.dart';
import '../export_domain.dart';

class CertificateRepository {
  final FirebaseStorage _firebaseStorage = FirebaseService().firebaseStorage;

  Future<String> addCertificate(
      CertificateModel certificateModel, String pdfPath) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        String pdfUrl = await _uploadPDF(pdfPath, userModel.userId);
        if (pdfUrl.isNotEmpty) {
          certificateModel.certificateFileUrl = pdfUrl;
          userModel.certeficatesList!.add(certificateModel);

          UserModel updatedUser = userModel.copyWith();
          await UserRepository().updateUser(updatedUser);
          result = 'success';
        } else {
          result = 'upload-pdf-failure';
        }
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> updateCertificate(CertificateModel certificateModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.certeficatesList![userModel.certeficatesList!.indexWhere(
                (element) =>
                    element.certificateId == certificateModel.certificateId)] =
            certificateModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteCertificate(CertificateModel certificateModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.certeficatesList!.removeWhere((element) {
          return element.certificateId == certificateModel.certificateId;
        });

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> _uploadPDF(String pdfPath, String userId) async {
    try {
      File pdfFile = File(pdfPath);
      String fileName = pdfFile.path.split('/').last;

      final storageRef = _firebaseStorage
          .ref()
          .child('certificate_pdfs')
          .child(userId)
          .child(fileName);

      final uploadTask = storageRef.putFile(pdfFile);
      final snapshot = await uploadTask;
      final pdfUrl = await snapshot.ref.getDownloadURL();

      return pdfUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Firebase Storage upload error: $e');
      }
      throw Exception('Failed to upload PDF');
    }
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';

class FirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> getDefaultAvatarUrl(String userId) async {
    ByteData byteData = await rootBundle.load(Assets.imagesDefaultAvatar);
    Uint8List fileData = byteData.buffer.asUint8List();

    Reference reference = _firebaseStorage
        .ref()
        .child('${FirebaseConstants.profilePicsCollection}/')
        .child('$userId/')
        .child(DateTime.now().toString());

    UploadTask uploadTask = reference.putData(fileData);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> putBlogPicToStorage({
    required bool isBlog,
    required String blogId,
    required XFile? selectedImage,
  }) async {
    File fileData = File(selectedImage!.path);
    Reference reference = _firebaseStorage
        .ref()
        .child(
            '${isBlog ? FirebaseConstants.blogPicsCollection : FirebaseConstants.inThePressPicsCollection}/')
        .child('$blogId/')
        .child(DateTime.now().toString());

    UploadTask uploadTask = reference.putFile(fileData);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String?> uploadCourseVideoAndSaveUrl(
      {required XFile? selectedVideo}) async {
    File file = File(selectedVideo!.path);

    TaskSnapshot snapshot = await _firebaseStorage
        .ref(
            '${FirebaseConstants.videosCollection}/${file.path.split('/').last}')
        .putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String?> uploadCourseThumbnailsAndSaveUrl(
      {required XFile? selectedCourseThumbnail}) async {
    File file = File(selectedCourseThumbnail!.path);

    TaskSnapshot snapshot = await _firebaseStorage
        .ref(
            '${FirebaseConstants.thumbnailsCollection}/${file.path.split('/').last}')
        .putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}

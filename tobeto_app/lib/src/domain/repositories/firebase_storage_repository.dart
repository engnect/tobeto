import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import '../../common/export_common.dart';

class FirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseService().firebaseStorage;

  Future<String> getDefaultAvatarUrl({
    required String userId,
  }) async {
    Uint8List fileData;

    ByteData byteData = await rootBundle.load(Assets.imagesDefaultAvatar);
    fileData = byteData.buffer.asUint8List();

    Reference reference = _firebaseStorage
        .ref()
        .child('${FirebaseConstants.profilePicsCollection}/')
        .child('$userId/')
        .child('avt-$userId');

    UploadTask uploadTask = reference.putData(fileData);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> updateUserAvatarAndGetUrl({
    required String userId,
    required File image,
  }) async {
    Uint8List fileData = await image.readAsBytes();

    Reference reference = _firebaseStorage
        .ref()
        .child('${FirebaseConstants.profilePicsCollection}/')
        .child('$userId/')
        .child('avt-$userId');

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

  Future<String?> uploadCourseVideoAndSaveUrl({
    required String videoId,
    required XFile? selectedVideo,
  }) async {
    File file = File(selectedVideo!.path);

    Reference reference = _firebaseStorage
        .ref()
        .child('${FirebaseConstants.videosCollection}/')
        .child('$videoId/')
        .child(videoId);

    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
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

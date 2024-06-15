import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
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
}
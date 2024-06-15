import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tobeto/src/common/constants/enums.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import '../../common/constants/firebase_constants.dart';
import '../../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  Future<void> registerUser({
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      if (userName.isNotEmpty ||
          userSurname.isNotEmpty ||
          userEmail.isNotEmpty) {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );

        String userAvatarUrl = await FirebaseStorageRepository()
            .getDefaultAvatarUrl(userCredential.user!.uid);

        UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          userName: userName,
          userSurname: userSurname,
          userEmail: userEmail,
          userAvatarUrl: userAvatarUrl,
          userRank: UserRank.student,
          userCreatedAt: DateTime.now(),
          userBirthDate: DateTime.now(),
          languageList: [],
          socialMediaList: [],
          skillsList: [],
          experiencesList: [],
          schoolsList: [],
          certeficatesList: [],
        );

        _users.doc(userCredential.user!.uid).set(userModel.toMap());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> singInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void signOutUser() async {
    await _firebaseAuth.signOut();
  }
}

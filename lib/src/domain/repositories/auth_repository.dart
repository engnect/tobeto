import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import '../../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> registerUser({
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
  }) async {
    String result = '';
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

        result = await UserRepository().addOrUpdateUser(userModel);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      result = e.toString();
    }
    return result;
  }

  Future<String> singInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    String result = '';
    try {
      if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
        result = 'success';
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      result = e.toString();
    }
    return result;
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }
}

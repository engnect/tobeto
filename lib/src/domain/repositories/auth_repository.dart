import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

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

        UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          userName: userName,
          userSurname: userSurname,
          userEmail: userEmail,
          userRank: 'student',
          userCreatedAt: DateTime.now(),
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
      print(e);
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
      print(e);
    }
  }

  void signOutUser() async {
    await _firebaseAuth.signOut();
  }
}

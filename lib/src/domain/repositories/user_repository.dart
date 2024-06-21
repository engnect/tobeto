import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  Future<UserModel?> getCurrentUser() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot = await _users.doc(currentUser.uid).get();
    return UserModel.fromMap(documentSnapshot.data()! as Map<String, dynamic>);
  }

  Stream<UserModel?> getUserStream() {
    User currentUser = _firebaseAuth.currentUser!;
    return _users.doc(currentUser.uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()! as Map<String, dynamic>);
      }
      return null;
    });
  }

  Future<UserModel?> getSpecificUserById(String userId) async {
    DocumentSnapshot documentSnapshot = await _users.doc(userId).get();
    return UserModel.fromMap(documentSnapshot.data()! as Map<String, dynamic>);
  }

  Future<String> addOrUpdateUser(UserModel updatedUser) async {
    String result = '';
    try {
      await _users.doc(updatedUser.userId).set(updatedUser.toMap());
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteUser(UserModel userModel) async {
    String result = '';

    try {
      await _users.doc(userModel.userId).delete();
      await AuthRepository().deleteUser();
      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return Utilities.errorMessageChecker(result);
  }
}

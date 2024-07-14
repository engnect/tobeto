import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/common/utilities/tbt_utilities.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import 'package:tobeto/src/models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseService().firebaseAuth;
  final FirebaseFirestore _firebaseFirestore =
      FirebaseService().firebaseFirestore;

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

    if (documentSnapshot.exists) {
      return UserModel.fromMap(
          documentSnapshot.data()! as Map<String, dynamic>);
    }
    return null;
  }

  // Future<String> addOrUpdateUser(UserModel updatedUser) async {
  //   String result = '';
  //   try {
  //     await _users.doc(updatedUser.userId).set(updatedUser.toMap());
  //     result = 'success';
  //   } on FirebaseAuthException catch (e) {
  //     result = e.toString();
  //   }
  //   return Utilities.errorMessageChecker(result);
  // }

  Future<String> addUser(UserModel usermodel) async {
    String result = '';
    try {
      await _users.doc(usermodel.userId).set(usermodel.toMap());
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> updateUser(UserModel usermodel) async {
    String result = '';
    try {
      await _users.doc(usermodel.userId).update(usermodel.toMap());
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.toString();
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<List<String>> getAdminIds() async {
    List<DocumentSnapshot> adminUsersDocumentSnapshots = [];
    List<String> adminUsersIdsList = [];
    QuerySnapshot querySnapshot = await FirebaseService()
        .firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .where('userRank', isEqualTo: UserRank.admin.index)
        .get();

    adminUsersDocumentSnapshots = querySnapshot.docs;
    for (var i = 0; i < adminUsersDocumentSnapshots.length; i++) {
      UserModel userModel = UserModel.fromMap(
          adminUsersDocumentSnapshots[i].data() as Map<String, dynamic>);
      adminUsersIdsList.add(userModel.userId);
    }

    return adminUsersIdsList;
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

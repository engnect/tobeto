import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
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

  Future<String> updateUser(UserModel updatedUser) async {
    UserModel? currentUser = await getCurrentUser();
    String result = '';
    if (currentUser != null) {
      try {
        await _users.doc(currentUser.userId).update(updatedUser.toMap());
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }
}

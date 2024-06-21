import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
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
          usertitle: 'Öğrenci',
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
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> signInWithGoogle() async {
    UserCredential userCredential;
    GoogleSignIn googleSignIn = GoogleSignIn();
    String result = '';
    String firstName = '';
    String lastName = '';
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
      );

      userCredential = await _firebaseAuth.signInWithCredential(credential);

      String? fullName = userCredential.user!.displayName!;

      // isim soyisim ayırma
      List<String> nameParts = fullName.split(' ');
      firstName = nameParts.isNotEmpty ? nameParts[0] : '';
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        userName: firstName,
        userSurname: lastName,
        userEmail: userCredential.user!.email!,
        userAvatarUrl: userCredential.user!.photoURL,
        userRank: UserRank.student,
        usertitle: 'Öğrenci',
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
    } on FirebaseException catch (e) {
      result = e.code;
    }

    return Utilities.errorMessageChecker(result);
  }

  Future<String> singInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    String result = '';
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> updatePassword({required String newPassword}) async {
    String result = '';
    _firebaseAuth.currentUser!.updatePassword(newPassword);
    try {
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> forgetPassword({required String email}) async {
    String result = '';

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> signOutUser() async {
    String result = '';
    try {
      await _firebaseAuth.signOut();
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteUser() async {
    String result = '';
    try {
      await _firebaseAuth.currentUser!.delete();
      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    return Utilities.errorMessageChecker(result);
  }
}

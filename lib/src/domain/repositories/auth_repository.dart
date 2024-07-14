import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../common/export_common.dart';
import '../../models/export_models.dart';
import '../export_domain.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseService().firebaseAuth;
  Future<String> registerUser({
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
  }) async {
    String result = '';
    try {
      if (userName.trim().isNotEmpty &&
          userSurname.trim().isNotEmpty &&
          userEmail.trim().isNotEmpty &&
          userPassword.trim().isNotEmpty &&
          confirmPassword.trim().isNotEmpty) {
        if (userPassword.trim() == confirmPassword.trim()) {
          UserCredential userCredential =
              await _firebaseAuth.createUserWithEmailAndPassword(
            email: userEmail,
            password: userPassword,
          );

          String userAvatarUrl = await FirebaseStorageRepository()
              .getDefaultAvatarUrl(userId: userCredential.user!.uid);

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

          await UserRepository().addUser(userModel);
          result = 'success';
        } else {
          result = 'password-not-match';
        }
      } else {
        result = 'empty-field';
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
    UserRepository userRepository = UserRepository();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
      );

      userCredential =
          await FirebaseService().firebaseAuth.signInWithCredential(credential);

      String? fullName = userCredential.user!.displayName!;

      List<String> nameParts = fullName.split(' ');
      firstName = nameParts.isNotEmpty ? nameParts[0] : '';
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      String userId = userCredential.user!.uid;

      UserModel? existingUser =
          await userRepository.getSpecificUserById(userId);

      if (existingUser == null) {
        UserModel userModel = UserModel(
          userId: userId,
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
        await userRepository.addUser(userModel);
      } else {
        await userRepository.updateUser(existingUser);
      }

      result = 'success';
    } on FirebaseException catch (e) {
      result = e.code;
    }

    return Utilities.errorMessageChecker(result);
  }

  Future<String> signInUser({
    required String userEmail,
    required String userPassword,
    required bool isVerified,
  }) async {
    String result = '';
    if (userEmail.trim().isNotEmpty &&
        userPassword.trim().isNotEmpty &&
        isVerified) {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
        result = 'success';
      } on FirebaseAuthException catch (e) {
        result = e.code;
      }
    } else {
      result = 'empty-field';
    }

    return Utilities.errorMessageChecker(result);
  }

  Future<String> updatePassword({
    required String confirmPassword,
    required String newPassword,
  }) async {
    String result = '';

    if (newPassword != confirmPassword) {
      result = 'password-not-match';
    } else {
      _firebaseAuth.currentUser!.updatePassword(newPassword);
      try {
        result = 'success';
      } on FirebaseAuthException catch (e) {
        result = e.code;
      }
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

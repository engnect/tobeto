import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class ExperienceRepository {
  final CollectionReference experienceCollection =
      FirebaseFirestore.instance.collection('experiencesList');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExperience(ExperienceModel experience) async {
    try {
      DocumentReference docRef =
          await experienceCollection.add(experience.toMap());
      experience.experienceId = docRef.id;

      UserModel? usermodel = await AuthRepository().getCurrentUser();
      if (usermodel!.experiencesList != null) {
        usermodel.experiencesList!.add(experience);
      } else {
        usermodel.experiencesList = [experience];
      }

      UserModel updatedUser = usermodel;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel.userId)
          .set(updatedUser.toMap());
    } catch (e) {
      throw Exception('Failed to add experience: $e');
    }
  }

  Future<void> updateExperience(ExperienceModel experience) async {
    try {
      await experienceCollection
          .doc(experience.experienceId)
          .update(experience.toMap());
    } catch (e) {
      throw Exception('Failed to update experience: $e');
    }
  }

  Future<void> deleteExperience(String experienceId) async {
    try {
      UserModel? user = await AuthRepository().getCurrentUser();

      if (user!.experiencesList != null) {
        print('User found: ${user.userId}');
        print('Experience List: ${user.experiencesList}');

        ExperienceModel? experienceToRemove;
        for (var exp in user.experiencesList!) {
          print('Checking experience: ${exp.experienceId}');
          if (exp.experienceId == experienceId) {
            experienceToRemove = exp;
            break;
          }
        }

        if (experienceToRemove != null) {
          print('Experience to remove found: ${experienceToRemove.toMap()}');

          await _firestore.collection('users').doc(user.userId).update({
            'experiencesList':
                FieldValue.arrayRemove([experienceToRemove.toMap()])
          });

          //await _firestore.collection('experiences').doc(experienceId).delete();

          print('Experience deleted successfully');
        } else {
          throw Exception('Experience not found in user\'s list');
        }
      } else {
        throw Exception('User or experiences list not found');
      }
    } catch (e) {
      print('Failed to delete experience: $e');
      throw Exception('Failed to delete experience: $e');
    }
  }
}

import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class ExperienceRepository {
  Future<String> addExperience(ExperienceModel experienceModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.experiencesList!.add(experienceModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

  Future<String> updateExperience(ExperienceModel experienceModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.experiencesList![userModel.experiencesList!.indexWhere(
                (element) =>
                    element.experienceId == experienceModel.experienceId)] =
            experienceModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

  Future<String> deleteExperience(ExperienceModel experienceModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.experiencesList!.removeWhere((element) {
          return element.experienceId == experienceModel.experienceId;
        });

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }
}

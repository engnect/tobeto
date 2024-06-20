import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class SkillRepository {
  Future<String> addSkill(SkillModel skillModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if(userModel != null) {
      try {
        userModel.skillsList!.add(skillModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

   Future<String> updateSkill(SkillModel skillModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.skillsList![userModel.skillsList!.indexWhere((element) =>
                element.skillId == skillModel.skillId)] =
            skillModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().updateUser(updatedUser);
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }


   Future<String> deleteSkill(SkillModel skillModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.skillsList!.removeWhere((element) {
          return element.skillId == skillModel.skillId;
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
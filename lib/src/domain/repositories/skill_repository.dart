import 'package:tobeto/src/domain/export_domain.dart';

import '../../common/export_common.dart';
import '../../models/export_models.dart';

class SkillRepository {
  Future<String> addSkill(SkillModel skillModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.skillsList!.add(skillModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> updateSkill(SkillModel skillModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.skillsList![userModel.skillsList!.indexWhere(
            (element) => element.skillId == skillModel.skillId)] = skillModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
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
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }
}

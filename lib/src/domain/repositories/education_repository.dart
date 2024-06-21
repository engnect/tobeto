import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class EducationRepository {
  Future<String> addEducation(EducationModel educaitonModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.schoolsList!.add(educaitonModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> updateEducation(EducationModel educationModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.schoolsList![userModel.schoolsList!.indexWhere((element) =>
                element.educationId == educationModel.educationId)] =
            educationModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteEducation(EducationModel educationModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.schoolsList!.removeWhere((element) {
          return element.educationId == educationModel.educationId;
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

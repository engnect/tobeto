import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/language_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class LanguageRepository {
  Future<String> addLanguage(LanguageModel languageModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.languageList!.add(languageModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

  Future<String> updateLanguage(LanguageModel languageModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.languageList![userModel.languageList!.indexWhere(
                (element) => element.languageId == languageModel.languageId)] =
            languageModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteLanguage(LanguageModel languageModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.languageList!.removeWhere((element) {
          return element.languageId == languageModel.languageId;
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

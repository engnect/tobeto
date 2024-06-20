import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/social_media_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class SocialMediaRepository {
  Future<String> addSocialMedia(SocialMediaModel socialMediaModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.socialMediaList!.add(socialMediaModel);

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

  Future<String> updateSocialMedia(SocialMediaModel socialMediaModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.socialMediaList![userModel.socialMediaList!.indexWhere(
                (element) =>
                    element.socialMediaId == socialMediaModel.socialMediaId)] =
            socialMediaModel;

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }

  Future<String> deleteSocialMedia(SocialMediaModel socialMediaModel) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    String result = '';
    if (userModel != null) {
      try {
        userModel.socialMediaList!.removeWhere((element) {
          return element.socialMediaId == socialMediaModel.socialMediaId;
        });

        UserModel updatedUser = userModel.copyWith();
        await UserRepository().addOrUpdateUser(updatedUser);
        result = 'success';
      } catch (e) {
        result = e.toString();
      }
    }
    return result;
  }
}

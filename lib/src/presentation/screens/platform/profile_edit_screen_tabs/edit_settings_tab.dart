import 'package:flutter/material.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_input_field.dart';
import 'package:tobeto/src/presentation/widgets/tbt_purple_button.dart';

class EditSettingsTab extends StatefulWidget {
  const EditSettingsTab({super.key});

  @override
  State<EditSettingsTab> createState() => _EditSettingsTabState();
}

class _EditSettingsTabState extends State<EditSettingsTab> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final bool _obscureNewPassword = true;
  final bool _obscureConfirmNewPassword = true;

  _updatePassword({
    required String confirmPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    String result = await AuthRepository().updatePassword(
      confirmPassword: confirmPassword,
      newPassword: newPassword,
    );
    if (!context.mounted) return;

    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: TBTInputField(
                          hintText: 'Yeni Şifre',
                          controller: _newPasswordController,
                          isObscure: _obscureNewPassword,
                          onSaved: (p) {},
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: TBTInputField(
                          hintText: 'Yeni Şifre Tekrar',
                          controller: _confirmNewPasswordController,
                          isObscure: _obscureConfirmNewPassword,
                          onSaved: (p) {},
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: TBTPurpleButton(
                          buttonText: 'Şifreyi Güncelle',
                          onPressed: () => _updatePassword(
                            confirmPassword: _confirmNewPasswordController.text,
                            newPassword: _newPasswordController.text,
                            context: context,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            UserModel? user =
                                await UserRepository().getCurrentUser();
                            UserRepository().deleteUser(user!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Üyeliği Sonlandır",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
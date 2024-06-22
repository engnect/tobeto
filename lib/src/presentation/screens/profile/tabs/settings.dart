import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  
  

  final bool _obscureOldPassword = true;
  final bool _obscureNewPassword = true;
  final bool _obscureConfirmNewPassword = true;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TBTInputField(
                hintText: 'Eski Şifre',
                controller: _oldPasswordController,
                isObscure: _obscureOldPassword,
                onSaved: (p) {},
                keyboardType: TextInputType.text,
                maxLines: 1,
                minLines: 1,
              ),
            ),
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
                buttonText: 'Kaydet',
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  UserModel? user = await  UserRepository().getCurrentUser();
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
    );
  }
}

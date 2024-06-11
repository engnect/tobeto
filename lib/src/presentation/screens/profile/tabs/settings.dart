import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTextFieldWithBorder({
      required TextEditingController controller,
      required String labelText,
      required bool obscureText,
      required VoidCallback toggleObscureText,
    }) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            contentPadding: const EdgeInsets.all(8),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: toggleObscureText,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            buildTextFieldWithBorder(
              controller: _oldPasswordController,
              labelText: 'Eski Şifre',
              obscureText: _obscureOldPassword,
              toggleObscureText: () {
                setState(() {
                  _obscureOldPassword = !_obscureOldPassword;
                });
              },
            ),
            const SizedBox(height: 24),
            buildTextFieldWithBorder(
                controller: _newPasswordController,
                labelText: 'Yeni Şifre',
                obscureText: _obscureNewPassword,
                toggleObscureText: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                }),
            const SizedBox(height: 24),
            buildTextFieldWithBorder(
              controller: _confirmNewPasswordController,
              labelText: 'Yeni Şifre Tekrar',
              obscureText: _obscureConfirmNewPassword,
              toggleObscureText: () {
                setState(() {
                  _obscureConfirmNewPassword = !_obscureConfirmNewPassword;
                });
              },
            ),
            const SizedBox(height: 24),
            TBTPurpleButton(
              buttonText: 'Kaydet',
              onPressed: () {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}

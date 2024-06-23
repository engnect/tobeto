import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/auth_input_widget.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          AuthInput(
            assetImagePath: Assets.imageUser,
            hintText: 'İsim',
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
          AuthInput(
            assetImagePath: Assets.imageUser,
            hintText: 'Soyisim',
            controller: _surnameController,
            keyboardType: TextInputType.name,
          ),
          AuthInput(
            assetImagePath: Assets.imageEmail,
            hintText: 'E-Posta',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          AuthInput(
            assetImagePath: Assets.imagePassword,
            hintText: 'Şifre',
            controller: _passwordController,
            isObscure: true,
            keyboardType: TextInputType.multiline,
          ),
          AuthInput(
            assetImagePath: Assets.imagePassword,
            hintText: 'Şifre',
            controller: _confirmPasswordController,
            isObscure: true,
            keyboardType: TextInputType.multiline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 7,
            ),
            child: TBTPurpleButton(
              buttonText: "Kayıt ol",
              onPressed: () async {
                await AuthRepository().registerUser(
                  userName: _nameController.text.trim(),
                  userSurname: _surnameController.text.trim(),
                  userEmail: _emailController.text.trim(),
                  userPassword: _passwordController.text.trim(),
                );
              },
            ),
          ),
          const SizedBox(height: kTextTabBarHeight),
        ],
      ),
    );
  }
}

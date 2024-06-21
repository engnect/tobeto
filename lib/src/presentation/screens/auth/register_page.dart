import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/email_input.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/password_input.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/user_input.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

bool showIcon = true;
bool showIcon2 = true;

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
          //İsim Kısmı
          UserInput(controller: _nameController, hintText: "İsim"),
          //Soyisim Kısmı
          UserInput(controller: _surnameController, hintText: "Soyisim"),
          // E-Mail Kısmı
          EmailInput(controller: _emailController, hintText: "E-Posta"),
          // Şifre Kısmı
          PasswordInput(controller: _passwordController, hintText: "Şifre"),
          //Şifre Tekrar
          PasswordInput(
              controller: _confirmPasswordController, hintText: "Şifre Tekrar"),
          //Giriş Yap butonu
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

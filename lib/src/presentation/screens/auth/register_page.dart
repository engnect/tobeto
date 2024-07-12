import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';

import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../widgets/export_widgets.dart';
import 'widgets/widgets.dart';

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

  _registerUser({
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
    required bool isConnected,
  }) async {
    String result = '';
    if (isConnected) {
      result = await AuthRepository().registerUser(
        userName: userName,
        userSurname: userSurname,
        userEmail: userEmail,
        userPassword: userPassword,
        confirmPassword: confirmPassword,
      );
    } else {
      result = 'İnternet Bağlantısı Yok!';
    }

    Utilities.showToast(toastMessage: result);
  }

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
    final netStatusCubit = context.watch<NetConnectionCubit>().state;
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
              onPressed: () => _registerUser(
                userName: _nameController.text,
                userSurname: _surnameController.text,
                userEmail: _emailController.text,
                userPassword: _passwordController.text,
                confirmPassword: _confirmPasswordController.text,
                isConnected: netStatusCubit,
              ),
            ),
          ),
          const SizedBox(height: kTextTabBarHeight),
        ],
      ),
    );
  }
}

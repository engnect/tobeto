import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/password_input.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _forgetPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _forgetPasswordController.dispose();
  }

  void _signinUser({
    required String userEmail,
    required String userPassword,
    required BuildContext context,
  }) async {
    String result = await AuthRepository().singInUser(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _signinWithGoogle({
    required BuildContext context,
  }) async {
    String result = await AuthRepository().signInWithGoogle();
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _forgetPassword({
    required TextEditingController forgetPasswordController,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('E-posta adresinizi giriniz!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TBTInputField(
                hintText: 'E-posta',
                controller: forgetPasswordController,
                onSaved: (p0) {},
                keyboardType: TextInputType.emailAddress,
              ),
              const Text(
                  'Eğer e-posta adresiniz sistemde kayıtlı ise e-posta 10dk içerisinde size ulaşır.'),
              const Text('Spam klasörünü kontrol edin!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String result = await AuthRepository().forgetPassword(
                    email: forgetPasswordController.text.trim());
                forgetPasswordController.clear();
                if (!context.mounted) return;
                Utilities.showSnackBar(
                    snackBarMessage: result, context: context);
              },
              child: const Text('Gönder'),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          // E-Mail Kısmı
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Color.fromRGBO(60, 60, 60, 1)),
                decoration: InputDecoration(
                  prefixIcon: Image.asset(Assets.imageEmail),
                  hintText: "E-posta",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(129, 129, 129, 1),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(138, 138, 138, 0.4),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(153, 51, 255, 0.4),
                      width: 4,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(129, 129, 129, 1),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Şifre Kısmı
          PasswordInput(controller: _passwordController),
          //Giriş Yap butonu
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 7,
            ),
            child: TBTPurpleButton(
              buttonText: "Giriş Yap",
              onPressed: () => _signinUser(
                userEmail: _emailController.text,
                userPassword: _passwordController.text,
                context: context,
              ),
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Color.fromRGBO(129, 129, 129, 1),
                  thickness: 3,
                  endIndent: 10,
                ),
              ),
              Text(
                "Ya da",
                style: TextStyle(color: Color.fromRGBO(110, 110, 110, 1)),
              ),
              Expanded(
                child: Divider(
                  color: Color.fromRGBO(129, 129, 129, 1),
                  thickness: 3,
                  indent: 10,
                ),
              ),
            ],
          ),
          //Google Butonu
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              onPressed: () => _signinWithGoogle(context: context),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      Assets.imageGoogle,
                      width: 32,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Google İle Giriş",
                        style: TextStyle(
                          color: Color.fromRGBO(100, 100, 100, 1),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _forgetPassword(
              forgetPasswordController: _forgetPasswordController,
              context: context,
            ),
            child: const Text(
              "Şifremi Unuttum",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(111, 111, 111, 1),
              ),
            ),
          ),
          const SizedBox(height: kTextTabBarHeight),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/password_input.dart';
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
              onPressed: () async {
                await AuthRepository().singInUser(
                  userEmail: _emailController.text,
                  userPassword: _passwordController.text,
                );
              },
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
              onPressed: () {
                // signInWithGoogle();
                if (kDebugMode) {
                  print("giriş yapa tıklandı");
                }
              },
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
            onTap: () {
              if (kDebugMode) {
                print("Şifremi unuttuma tıklandı");
              }
            },
            child: const Text(
              "Şifremi Unuttum",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(111, 111, 111, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

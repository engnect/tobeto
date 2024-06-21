import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';

import '../../../common/constants/assets.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Color.fromRGBO(60, 60, 60, 1)),
                decoration: InputDecoration(
                  prefixIcon: Image.asset(Assets.imageUser),
                  hintText: "İsim",
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
          //Soyisim Kısmı
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: _surnameController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  color: Color.fromRGBO(60, 60, 60, 1),
                ),
                decoration: InputDecoration(
                  prefixIcon: Image.asset(Assets.imageUser),
                  hintText: "Soyisim",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Color.fromRGBO(60, 60, 60, 1)),
                autocorrect: false,
                obscureText: showIcon,
                decoration: InputDecoration(
                  prefixIcon: Image.asset(Assets.imagePassword),
                  suffixIcon: showIcon
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showIcon = !showIcon;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_outlined,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              showIcon = !showIcon;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                          ),
                        ),
                  hintText: "Şifre",
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
          //Şifre Tekrar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Color.fromRGBO(60, 60, 60, 1)),
                autocorrect: false,
                obscureText: showIcon2,
                decoration: InputDecoration(
                  prefixIcon: Image.asset(Assets.imagePassword),
                  suffixIcon: showIcon2
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showIcon2 = !showIcon2;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_outlined,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              showIcon2 = !showIcon2;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                          ),
                        ),
                  hintText: "Şifre Tekrar",
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

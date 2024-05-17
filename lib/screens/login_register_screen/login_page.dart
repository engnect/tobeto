import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:tobeto/screens/login_register_screen/register_page.dart';
import 'package:tobeto/screens/login_register_screen/widgets/extract_login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedGradientBorder(
                animationTime: 11,
                gradientColors: const [
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.purple,
                  Colors.orange,
                ],
                glowSize: 2,
                borderSize: 2,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                      // gradient: RadialGradient(colors: colors),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(Assets.imagesTobetoLogo),
                          ),
                          TBTInputField(
                            hintText: 'E - Posta',
                            controller: emailController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TBTInputField(
                            hintText: 'Şifre',
                            controller: passwordController,
                            isObscure: true,
                            keyboardType: TextInputType.multiline,
                            onSaved: (p0) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TBTPurpleButton(
                              buttonText: 'Giriş Yap',
                              onPressed: () {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Şifremi Unuttum"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 18, 5, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Henüz üye değil misin?"),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: const RegisterPage(),
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        curve: Curves.fastEaseInToSlowEaseOut,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        reverseDuration:
                                            const Duration(milliseconds: 600),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    " Kayıt Ol",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

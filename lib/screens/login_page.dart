import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tobeto/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        child: Image.asset("lib/assets/images/tobeto-logo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "E-Posta"),
                          onSaved: (newValue) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Şifre",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 153, 51, 255),
                                width: 2,
                              ))),
                          autocorrect: false,
                          obscureText: true,
                          onSaved: (newValue) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 153, 51, 255),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                    duration: const Duration(milliseconds: 600),
                                    reverseDuration:
                                        const Duration(milliseconds: 600),
                                  ),
                                );
                              },
                              child: const Text(
                                " Kayıt Ol",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}

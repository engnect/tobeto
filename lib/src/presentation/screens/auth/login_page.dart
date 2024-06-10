import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/presentation/screens/auth/register_page.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';

import '../../widgets/input_field.dart';
import '../../widgets/purple_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final controller = ScrollController();

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: TBTAppBar(controller: controller),
      drawer: const TBTDrawer(),
      body: SingleChildScrollView(
        controller: controller,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 50,
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
                            maxLines: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TBTPurpleButton(
                              buttonText: 'Giriş Yap',
                              onPressed: () async {
                                await AuthRepository().singInUser(
                                  userEmail: emailController.text,
                                  userPassword: passwordController.text,
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                signInWithGoogle();
                                print("giriş yapa tıklandı");
                              },
                              child: const Text("Google İle Giriş")),
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
                                        child: const RegisterScreen(),
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
                                    "Kayıt Ol",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

Future<void> signInWithGoogle() async {
  // Oturum açma sürecini başlat
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  // Süreç içerisinden bilgileri al
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  // Kullanıcı nesnesi oluştur
  final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken, idToken: gAuth.idToken);

  // Kullanıcı girişini sağla

  // ignore: unused_local_variable
  final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
}

import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:tobeto/screens/login_register_screen/widgets/input_field.dart';
import 'package:tobeto/screens/login_register_screen/widgets/purple_button.dart';
import 'package:tobeto/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/widgets/tbt_drawer_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final controller = ScrollController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: TbtAppBar(controller: controller),
        drawer: const TbtDrawer(),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
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
                            hintText: 'İsim',
                            controller: nameController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.name,
                          ),
                          TBTInputField(
                            hintText: 'Soy İsim',
                            controller: surnameController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.name,
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
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                            isObscure: true,
                            maxLines: 1,
                          ),
                          TBTInputField(
                            hintText: 'Şifre Tekrar Giriniz',
                            controller: confirmPasswordController,
                            onSaved: (p0) {},
                            keyboardType: TextInputType.multiline,
                            isObscure: true,
                            maxLines: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TBTPurpleButton(
                              buttonText: 'Kayıt Ol',
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 18, 5, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Zaten bir hesabın var mı?"),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    " Giriş yap",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
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

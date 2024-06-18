import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/screens/auth/login_page.dart';
import 'package:tobeto/src/presentation/screens/auth/register_page.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  bool isLoginSelected = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _appbarcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _flip() {
    if (isLoginSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isLoginSelected = !isLoginSelected;
  }

  @override
  void dispose() {
    _controller.dispose();
    _appbarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double switchWidth =
        screenWidth * 0.8; // Switch genişliğini ekranın %60'ı yap
    const double switchHeight = 50;
    final double buttonWidth = switchWidth / 2;
    return Scaffold(
      appBar: TBTAppBar(controller: _appbarcontroller),
      body: SingleChildScrollView(
        controller: _appbarcontroller,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(Assets.imagesTobetoLogo),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Hoşgeldiniz",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 24,
                      color: Color.fromRGBO(80, 80, 80, 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Stack(
                  children: [
                    Container(
                      // Border vermek için
                      width: switchWidth + 10,
                      height: switchHeight + 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular((switchHeight + 10) / 2),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // isLoginSelected = !isLoginSelected;
                            _flip();
                          });
                        },
                        child: Container(
                          width: switchWidth,
                          height: switchHeight,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(switchHeight / 2),
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeInOut,
                                left: isLoginSelected ? 0 : buttonWidth,
                                child: Container(
                                  width: buttonWidth,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Giriş Yap',
                                          style: TextStyle(
                                            color: isLoginSelected
                                                ? Colors.purple
                                                : Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Kayıt Ol',
                                          style: TextStyle(
                                            color: !isLoginSelected
                                                ? Colors.purple
                                                : Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
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
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  double angle = _animation.value * pi;
                  bool isReverse = false;
                  if (angle > pi / 2) {
                    angle = pi - angle;
                    isReverse = true;
                  }
                  return Transform(
                    transform: Matrix4.rotationY(angle),
                    alignment: Alignment.center,
                    child: isReverse
                        ? const RegisterScreen()
                        : const LoginScreen(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

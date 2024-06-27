import 'dart:math';
import 'package:flutter/material.dart';

import '../../../common/export_common.dart';
import '../../widgets/export_widgets.dart';
import '../export_screens.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLoginSelected = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void _flip() {
    if (isLoginSelected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isLoginSelected = !isLoginSelected;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double switchWidth =
        screenWidth * 0.8; // Switch genişliğini ekranın %60'ı yap
    const double switchHeight = 50;
    final double buttonWidth = switchWidth / 2;
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
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
                              color: Color.fromRGBO(80, 80, 80, 1),
                            ),
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
                                  borderRadius: BorderRadius.circular(
                                      (switchHeight + 10) / 2),
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
                                      borderRadius: BorderRadius.circular(
                                          switchHeight / 2),
                                    ),
                                    child: Stack(
                                      children: [
                                        AnimatedPositioned(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.easeInOut,
                                          left:
                                              isLoginSelected ? 0 : buttonWidth,
                                          child: Container(
                                            width: buttonWidth,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

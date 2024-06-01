import 'package:flutter/material.dart';
import 'package:scroll_app_bar_2_0_0_custom_fix/scroll_app_bar.dart';
import 'package:tobeto/constants/assets.dart';

class TbtAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController controller;
  const TbtAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollAppBar(
      controller: controller,
      centerTitle: true,
      title: Image.asset(
        Assets.imagesTobetoLogo,
        width: 200,
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

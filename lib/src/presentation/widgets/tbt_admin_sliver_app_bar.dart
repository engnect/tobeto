import 'package:flutter/material.dart';

class TBTAdminSliverAppBar extends StatelessWidget {
  const TBTAdminSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      centerTitle: true,
      floating: true,
      snap: true,
      title: const Text(
        "Admin Menü",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }
}

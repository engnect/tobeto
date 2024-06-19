import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';

class TBTSliverAppBar extends StatelessWidget {
  const TBTSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      snap: true,
      title: Image.asset(
        Assets.imagesTobetoLogo,
        width: 200,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }
}

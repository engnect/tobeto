import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouterTransitionAnimation {
  static PageTransition<dynamic> tbtPageTransition({required Widget child}) {
    return PageTransition(
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}

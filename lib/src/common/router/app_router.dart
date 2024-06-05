import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/screens/about_us/about_us_screen.dart';
import 'package:tobeto/src/presentation/screens/auth/extract_login.dart';
import 'package:tobeto/src/presentation/screens/calendar/calendar_screen.dart';
import 'package:tobeto/src/presentation/screens/contact_us/contact_us_screen.dart';
import 'package:tobeto/src/presentation/screens/course/course_screen.dart';
import 'package:tobeto/src/presentation/screens/error/error_screen.dart';
import 'package:tobeto/src/presentation/screens/for_companies/for_companies_screen.dart';
import 'package:tobeto/src/presentation/screens/for_individuals/for_individuals_page.dart';
import 'package:tobeto/src/presentation/screens/home/home_screen.dart';
import 'package:tobeto/src/presentation/screens/in_the_press/in_the_press_screen.dart';
import 'package:tobeto/src/presentation/screens/platform/extract_home_page.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteNames.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRouteNames.aboutUsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const AboutUsScreen(),
        );
      case AppRouteNames.contactUsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ContactUsScreen(),
        );
      case AppRouteNames.courseScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const CourseScreen(),
        );
      case AppRouteNames.forIndividualsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ForIndividualsScreen(),
        );
      case AppRouteNames.forCompaniesScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ForCompaniesScreen(),
        );
      case AppRouteNames.platformScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const PlatformScreen(),
        );
      case AppRouteNames.loginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRouteNames.registerScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case AppRouteNames.inThePressScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const InThePressScreen(),
        );
      case AppRouteNames.profileScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case AppRouteNames.calendarScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const CalendarScreen(),
        );
      // error
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
    }
  }
}

class AppRouteNames {
  static const String homeRoute = '/';
  static const String aboutUsScreenRoute = '/aboutUsScreen';
  static const String contactUsScreenRoute = '/contactUsScreen';
//TODO: kurs ekranına bakılcak!
  static const String courseScreenRoute = '/courseScreen';
  static const String forIndividualsScreenRoute = '/forIndividualsScreen';
  static const String forCompaniesScreenRoute = '/forCompaniesScreen';
  static const String platformScreenRoute = '/platformScreen';
  static const String loginScreenRoute = '/loginScreen';
  static const String registerScreenRoute = '/registerScreen';
  static const String inThePressScreenRoute = '/InThePressScreen';
  static const String profileScreenRoute = '/profileScreen';
  static const String calendarScreenRoute = '/calendarScreen';
}

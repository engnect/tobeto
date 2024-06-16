import 'package:flutter/material.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';
import 'package:tobeto/src/common/router/app_route_transition_animation_settings.dart';
import 'package:tobeto/src/presentation/screens/about_us/about_us_screen.dart';
import 'package:tobeto/src/presentation/screens/auth/extract_login.dart';
import 'package:tobeto/src/presentation/screens/blog/blog_screen.dart';
import 'package:tobeto/src/presentation/screens/calendar/calendar_screen.dart';
import 'package:tobeto/src/presentation/screens/contact_us/contact_us_screen.dart';
import 'package:tobeto/src/presentation/screens/course/course_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/admin_announcement/admin_announcements_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/admin_contact_forms/admin_contact_forms_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/blog_page/blog_admin_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/course_page/course_video_add_edit.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/event_screen/admin_event_screen.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/in_the_press_admin/in_the_press_add_edit.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/staff_page/staff_add_edit.dart';
import 'package:tobeto/src/presentation/screens/error/error_screen.dart';
import 'package:tobeto/src/presentation/screens/for_companies/for_companies_screen.dart';
import 'package:tobeto/src/presentation/screens/for_individuals/for_individuals_page.dart';
import 'package:tobeto/src/presentation/screens/home/home_screen.dart';
import 'package:tobeto/src/presentation/screens/in_the_press/in_the_press_screen.dart';
import 'package:tobeto/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tobeto/src/presentation/screens/platform/platform_screen.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_screen.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteNames.homeRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const HomeScreen(),
        );
      case AppRouteNames.onboardingRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const OnBoardingScreen(),
        );
      case AppRouteNames.aboutUsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AboutUsScreen(),
        );
      case AppRouteNames.contactUsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ContactUsScreen(),
        );
      case AppRouteNames.courseScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const CourseScreen(),
        );
      case AppRouteNames.forIndividualsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ForIndividualsScreen(),
        );
      case AppRouteNames.forCompaniesScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ForCompaniesScreen(),
        );
      case AppRouteNames.platformScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const PlatformScreen(),
        );
      case AppRouteNames.loginScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const LoginScreen(),
        );
      case AppRouteNames.registerScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const RegisterScreen(),
        );
      case AppRouteNames.inThePressScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const InThePressScreen(),
        );
      case AppRouteNames.profileScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ProfileScreen(),
        );
      case AppRouteNames.calendarScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const CalendarScreen(),
        );
      case AppRouteNames.staffAddEditScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const StaffAddEdit(),
        );
      case AppRouteNames.inThePressAddEditScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const InThePressAddEdit(),
        );
      case AppRouteNames.blogScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const BlogScreen(),
        );

      // Admin sayfaları
      case AppRouteNames.adminBlogScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminBlogScreen(),
        );
      case AppRouteNames.adminEventScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminEventScreen(),
        );
      case AppRouteNames.adminContactFormScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminContactFormsScreen(),
        );
      case AppRouteNames.adminAnnouncementsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminAnnouncementsScreen(),
        );
      case AppRouteNames.adminCourseVideoAddEdit:
        return MaterialPageRoute(
          builder: (_) => const CourseVideoAddEdit(),
        );

      // error
      default:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ErrorScreen(),
        );
    }
  }
}

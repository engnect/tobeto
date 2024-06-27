import 'package:flutter/material.dart';
import '../../presentation/screens/export_screens.dart';
import 'router.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

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
          child: const CourseTabScreen(),
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
      case AppRouteNames.auhtScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AuthScreen(),
        );
      case AppRouteNames.inThePressScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const InThePressScreen(),
        );
      case AppRouteNames.profileScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ProfileEditScreen(),
        );
      case AppRouteNames.calendarScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const CalendarScreen(),
        );
      case AppRouteNames.blogScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const BlogScreen(),
        );

      // Admin sayfaları
      case AppRouteNames.adminAnnouncementsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminAnnouncementsScreen(),
        );
      case AppRouteNames.adminApplicationsScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminApplicationsScreen(),
        );
      case AppRouteNames.adminBlogScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminBlogScreen(),
        );
      case AppRouteNames.adminContactFormScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminContactFormsScreen(),
        );
      case AppRouteNames.adminCourseScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminCourseScreen(),
        );
      case AppRouteNames.adminCourseVideoScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminCourseVideoScreen(),
        );
      case AppRouteNames.adminEventScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminEventScreen(),
        );
      case AppRouteNames.adminInThePressScreenRoute:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const AdminInThePressScreen(),
        );
      case AppRouteNames.adminUserListScreenRoute:
        if (args is int) {
          return AppRouterTransitionAnimation.tbtPageTransition(
            child: UserListScreen(userRankIndex: args),
          );
        }
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ErrorScreen(),
        );

      // error screen
      default:
        return AppRouterTransitionAnimation.tbtPageTransition(
          child: const ErrorScreen(),
        );
    }
  }
}

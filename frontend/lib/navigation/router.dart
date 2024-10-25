import 'package:flutter/material.dart';
import 'package:frontend/navigation/route_names.dart';
import 'package:frontend/screens/home.dart';
import 'package:frontend/screens/home_drawer.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/profile_edit.dart';
import 'package:frontend/screens/registration.dart';
import 'package:frontend/screens/settings.dart';
import 'package:frontend/screens/settings_drawer.dart';
import 'package:frontend/screens/template/app_template.dart';
import 'package:frontend/screens/profile_drawer.dart';
import 'package:go_router/go_router.dart';

import '../screens/onboarding/onboarding_user.dart';
import '../screens/onboarding/onboarding_welcome.dart';
import '../screens/template/onboarding_template.dart';

// List of the routes for the app with footer menu navigation
final List<RouteBase> footerMenuRoutes = [
  GoRoute(
    path: routeLogin,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: routeRegistration,
    builder: (context, state) => const RegistrationPage(),
  ),
  GoRoute(
    path: routeProfileEdit,
    builder: (context, state) => const ProfileEditPage(),
  ),
  // ShellRoute for the onboarding pages
  ShellRoute(
    builder: (context, state, child) {
      return OnboardingTemplate(child: child);
    },
    routes: [
      GoRoute(
        path: routeOnboardingWelcome,
        builder: (context, state) =>
            const OnboardingWelcomePage(), // Display the HomePage widget
      ),
      GoRoute(
        path: routeOnboardingUser,
        builder: (context, state) =>
            const OnboardingUserPage(), // Display the ProfilePage widget
      ),
    ],
  ),
  // ShellRoute for the main app structure with navigation
  ShellRoute(
    builder: (context, state, child) {
      return AppTemplate(child: child);
    },
    routes: [
      GoRoute(
        path: routeHome,
        builder: (context, state) =>
            const HomePage(), // Display the HomePage widget
      ),
      GoRoute(
        path: routeProfile,
        builder: (context, state) =>
            const ProfilePage(), // Display the ProfilePage widget
      ),
      GoRoute(
        path: routeSettings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  ),
];
// List of the routes for the app with drawer menu navigation
final List<RouteBase> drawerMenuRoutes = [
  GoRoute(
    path: routeLogin,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: routeHome,
    builder: (context, state) => const HomeDrawerPage(),
  ),
  GoRoute(
    path: routeProfile,
    builder: (context, state) => const ProfileDrawerPage(),
  ),
  GoRoute(
    path: routeSettings,
    builder: (context, state) => const SettingsDrawerPage(),
  ),
  GoRoute(
    path: routeProfileEdit,
    builder: (context, state) => const ProfileEditPage(),
  ),
];

bool isFooterMenuNavigationActive() {
  String navigationType = const String.fromEnvironment('NAVIGATION_TYPE');
  return navigationType == 'footer';
}

// Global key to manage the navigator state
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: routeHome,
  navigatorKey: _navigatorKey,
  routes: isFooterMenuNavigationActive() ? footerMenuRoutes : drawerMenuRoutes,
);

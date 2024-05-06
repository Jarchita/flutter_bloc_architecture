import 'package:flutter/material.dart';
import '../screens/home_base/home_base_screen.dart';

import '../screens/login/login_screen.dart';
import '../screens/splash/splash_screen.dart';

/// Purpose : We will provide a route constants here
class RouteConstants {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
}

/// Purpose : This is maned router defined to generate route for the name.

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) =>
      MaterialPageRoute(builder: (_) {
        switch (settings.name) {
          case RouteConstants.splashRoute:
            return const SplashScreen();
          case RouteConstants.loginRoute:
            return const LoginScreen();
          case RouteConstants.homeRoute:
            return const HomeBaseScreen();

          default:
            return Center(child: Text('No route defined for $settings.name'));
        }
      });
}

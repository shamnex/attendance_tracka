import 'package:attendance_tracka/src/features/auth/screens/auth_home_screen.dart';
import 'package:attendance_tracka/src/features/welcome/screens/explanation_screen.dart';
import 'package:attendance_tracka/src/features/welcome/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = "/welcome";
  static const String explanation = "/explanation";
  static const String auth = "/auth";

  static Route<dynamic> router(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      return _widgetBuilder(settings, context);
    });
  }

  static Widget _widgetBuilder(RouteSettings settings, context) {
    switch (settings.name) {
      case welcome:
        return WelcomeScreen();
      case auth:
        return AuthHomeScreen();
      case explanation:
        return ExplanationScreen();
      default:
        return WelcomeScreen();
    }
  }
}

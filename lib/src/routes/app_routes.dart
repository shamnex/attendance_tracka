import 'package:attendance_tracka/src/features/auth/screens/auth_home_screen.dart';
import 'package:attendance_tracka/src/features/home/home_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/welcome/explanation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = "/home";
  static const String explanation = "/explanation";
  static const String auth = "/auth";

  static Route<dynamic> router(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      return _widgetBuilder(settings, context);
    });
  }

  static Widget _widgetBuilder(RouteSettings settings, context) {
    switch (settings.name) {
      case home:
        return HomeScreen();
      case auth:
        return AuthHomeScreen();
      case explanation:
        return ExplanationScreen();
      default:
        return HomeScreen();
    }
  }
}

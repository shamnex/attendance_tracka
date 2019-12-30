import 'package:attendance_tracka/src/features/welcome/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = "/welcome";

  static Route<dynamic> router(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      return _widgetBuilder(settings, context);
    });
  }

  static Widget _widgetBuilder(RouteSettings settings, context) {
    switch (settings.name) {
      case welcome:
        return WelcomeScreen();
      default:
        return WelcomeScreen();
    }
  }
}

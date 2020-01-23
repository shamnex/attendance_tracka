import 'package:flutter/cupertino.dart';

import 'add_volunteers/add_volunteers_screen.dart';
import 'organiser_screen.dart';

class OrganizerRoutes {
  static const String home = "/organizers";
  static const String addVolunteers = "/organizers/new";
  static const String signup = "/organizers/signup";

  static Route<dynamic> configureRoutes(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      return _widgetBuilder(settings, context);
    });
  }

  static Widget _widgetBuilder(RouteSettings settings, context) {
    switch (settings.name) {
      case addVolunteers:
        return AddVolunteersScreen();
      case home:
        return OrganiserScreen();
      default:
        return OrganiserScreen();
    }
  }
}

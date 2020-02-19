import 'package:attendance_tracka/src/features/auth/screens/auth_home_screen.dart';
import 'package:attendance_tracka/src/features/home/home_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/mark_attendance/mark_attendance_bloc/mark_attendance_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/mark_attendance/mark_attendance_route_argument.dart';
import 'package:attendance_tracka/src/features/home/screens/mark_attendance/mark_attendance_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/mark_attendance/scan_qr_code_bloc/scan_qr_code_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/welcome/explanation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service_locator.dart';

class AppRoutes {
  static const String home = "/home";
  static const String explanation = "/explanation";
  static const String auth = "/auth";
  static const String scan = "/scan";

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
      case scan:
        final MarkAttendanceRouteArguments args = settings.arguments;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ScanQRCodeBloc()),
            BlocProvider(
                create: (context) => MarkAttendanceBloc(
                      sl(),
                    )),
          ],
          child: MarkAttendanceScreen(
            apiURL: args.apiURL,
            iteration: args.iteration,
          ),
        );
      default:
        return HomeScreen();
    }
  }
}

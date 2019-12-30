import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: Material(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: AuthRoutes.configureRoutes,
        ),
      ),
    );
  }
}

import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/login/bloc/login_bloc_bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc(sl())),
          BlocProvider<SignupBloc>(create: (context) => SignupBloc(sl())),
        ],
        child: Material(
          child: Navigator(
            key: _navigatorKey,
            onGenerateRoute: AuthRoutes.configureRoutes,
          ),
        ),
      ),
    );
  }
}

import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/api_bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/check_volunteer_password_bloc/check_volunteer_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';
import 'login/bloc/bloc.dart';

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
          BlocProvider<GetApiUrlBloc>(create: (context) => GetApiUrlBloc(sl())),
          BlocProvider<CheckVolunteerPasswordBloc>(create: (context) => CheckVolunteerPasswordBloc(sl())),
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

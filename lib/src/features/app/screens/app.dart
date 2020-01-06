import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/home/home_screen.dart';
import 'package:attendance_tracka/src/features/onboarding/screens/onboard_screen.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {},
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {},
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
        return MaterialApp(
          showSemanticsDebugger: false,
          theme: appThemeData[appState.theme],
          onGenerateRoute: AppRoutes.router,
          home: Material(
            child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeIn,
                duration: Duration(milliseconds: 400),
                child: appState.hasOnboarded ? const HomeScreen() : const OnboardingScreen()),
          ),
        );
      }),
    );
  }
}

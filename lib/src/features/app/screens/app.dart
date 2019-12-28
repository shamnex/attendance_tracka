import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/onboarding/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return MaterialApp(
        showSemanticsDebugger: false,
        theme: appThemeData[appState.theme],
        builder: (context, home) {
          if (!appState.hasOnboarded) {
            return OnboardingScreen();
          }
          return Scaffold(body: Center(child: Text('Hello World')));
        },
      );
    });
  }
}

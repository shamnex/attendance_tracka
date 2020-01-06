import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/organiser_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/volunteer/volunteer_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthInitialState || authState is AuthLoading) {
            return Center(
              child: Text('Tracka'),
            );
          }
          if (authState is AuthUnAuthenticated) {
            return WelcomeScreen();
          }
          return appState.mode == AppMode.organizer ? const OrganiserScreen() : const VolunteerScreen();
        },
      );
    });
  }
}

import 'package:attendance_tracka/src/features/app/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return MaterialApp(
        theme: appThemeData[appState.theme],
        home: Center(
          child: Text('Hello World'),
        ),
      );
    });
  }
}

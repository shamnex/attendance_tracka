import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganiserScreen extends StatefulWidget {
  const OrganiserScreen({Key key}) : super(key: key);

  @override
  _OrganiserScreenState createState() => _OrganiserScreenState();
}

class _OrganiserScreenState extends State<OrganiserScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      final user = appState.currentUser;
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(children: <Widget>[
              const Spacer(),
              Expanded(child: Text('Welcome ${user.email}')),
              Expanded(child: Text('Organiser Screen')),
              AppButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(Deauthenticate());
                },
                child: Text(
                  'SIGN OUT',
                  style: textTheme.button.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 25),
            ]),
          ),
        ),
      );
    });
  }
}

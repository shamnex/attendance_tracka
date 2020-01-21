import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
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
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Expanded(
                  child: Center(
                    child: StaggeredAnimatedColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Welcome ${user.email}'),
                        Text('Organiser Screen'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: StaggeredAnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AppButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)..pushReplacementNamed(AppRoutes.addVolunteer);
                        },
                        child: Text(
                          'Add Volunteers',
                          style: textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(Deauthenticate());
                        },
                        child: Text(
                          'SIGN OUT',
                          style: textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
              ]),
            ),
          ),
        ),
      );
    });
  }
}

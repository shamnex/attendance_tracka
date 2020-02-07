import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/routes.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class OrganiserScreen extends StatefulWidget {
  const OrganiserScreen({Key key}) : super(key: key);

  @override
  _OrganiserScreenState createState() => _OrganiserScreenState();
}

class _OrganiserScreenState extends State<OrganiserScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  OrganizerBloc organizerBloc;
  AppBloc appBloc;
  @override
  void initState() {
    appBloc = context.bloc();
    organizerBloc = context.bloc()..add(GetVolunteers(appBloc.state.currentUser));

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return BlocBuilder<OrganizerBloc, OrganizerState>(builder: (context, organiserState) {
        final user = appState.currentUser;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('HOME'),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  Expanded(
                    child: Center(
                      child: StaggeredAnimatedColumn(
                        animationController: _animationController,
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
                      animationController: _animationController,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AppButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(OrganizerRoutes.addVolunteers);
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
    });
  }
}

import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/participants/participants_bloc_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import 'add_volunteers/bloc/add_volunteers_bloc.dart';
import 'bloc/tab/organiser_screen_tab_bloc.dart';
import 'bloc/volunteers/bloc.dart';
import 'organiser_service_locator.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class OrganizerScreenHomeScreen extends StatefulWidget {
  const OrganizerScreenHomeScreen();

  @override
  _OrganizerScreenHomeScreenState createState() => _OrganizerScreenHomeScreenState();
}

class _OrganizerScreenHomeScreenState extends State<OrganizerScreenHomeScreen> {
  @override
  void initState() {
    OrganiserService.init(BlocProvider.of<AppBloc>(context).state.flavor);
    super.initState();
  }

  @override
  void dispose() {
    OrganiserService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<VolunteersBloc>(create: (context) => sl()),
          BlocProvider<AddVolunteersBloc>(create: (context) => sl()),
          BlocProvider<OrganiserTabBloc>(create: (context) => sl()),
          BlocProvider<ParticipantsBloc>(create: (context) => sl()),
        ],
        child: Material(
          child: Navigator(
            key: _navigatorKey,
            onGenerateRoute: OrganizerRoutes.configureRoutes,
          ),
        ),
      ),
    );
  }
}

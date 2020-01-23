import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/organizer_repository.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import 'bloc/organizer_screen_bloc.dart';
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
          BlocProvider<OrganizerScreenBloc>(create: (context) => sl()),
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

import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organiser_screen_tab_event.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/partials/home_tab_screen.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/partials/tab_button.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/partials/volunteers_list_tab_screen.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:attendance_tracka/src/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/participants/participants_bloc_bloc.dart';
import 'bloc/participants/participants_bloc_event.dart';
import 'bloc/tab/organiser_screen_tab_bloc.dart';
import 'bloc/tab/organizer_screen_tab.dart';
import 'bloc/volunteers/bloc.dart';
import 'bloc/volunteers/volunteers_bloc.dart';

class OrganiserScreen extends StatefulWidget {
  const OrganiserScreen({Key key}) : super(key: key);

  @override
  _OrganiserScreenState createState() => _OrganiserScreenState();
}

class _OrganiserScreenState extends State<OrganiserScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  VolunteersBloc organizerBloc;
  ParticipantsBloc particiapantsBLoc;
  AppBloc appBloc;
  @override
  void initState() {
    appBloc = context.bloc();
    particiapantsBLoc = context.bloc();
    organizerBloc = context.bloc();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.forward();
    ScreenUtils.onWidgetDidBuild(() {
      if (appBloc.state.userLoggedIn) {
        organizerBloc..add(GetVolunteers(appBloc.state.currentUser));
        particiapantsBLoc..add(GetParticipants(appBloc.state.currentUser.apiURL));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(listenWhen: (prev, current) {
      return !prev.userLoggedIn && current.userLoggedIn;
    }, listener: (context, state) {
      organizerBloc..add(GetVolunteers(appBloc.state.currentUser));
      particiapantsBLoc..add(GetParticipants(appBloc.state.currentUser.apiURL));
    }, builder: (context, appState) {
      return BlocBuilder<VolunteersBloc, VolunteersState>(builder: (context, organiserState) {
        return BlocBuilder<OrganiserTabBloc, OrganizerScreenTab>(builder: (context, activeTab) {
          final textTheme = Theme.of(context).textTheme;
          final user = appState.currentUser;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              tooltip: 'Mark Attendance',
              child: SizedBox.expand(
                child: Container(
                  child: Icon(AppIcons.barcode),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.scan);
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: Stack(
              children: <Widget>[
                Container(
                  height: kToolbarHeight,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: AppColors.background,
                      blurRadius: 40,
                    )
                  ]),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  child: BottomAppBar(
                    shape: CircularNotchedRectangle(),
                    color: Colors.white,
                    elevation: 0.0,
                    notchMargin: 5,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TabButton(
                              activeIcon: Icon(
                                AppIcons.home,
                                color: AppColors.secondary.shade900,
                              ),
                              inactiveIcon: Icon(
                                AppIcons.home,
                                color: Colors.grey.shade300,
                              ),
                              isActive: activeTab == OrganizerScreenTab.home,
                              onPressed: () {
                                context.bloc<OrganiserTabBloc>().add(TabChanged(OrganizerScreenTab.home));
                              },
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Expanded(
                            child: TabButton(
                              activeIcon: Icon(
                                AppIcons.group_senior,
                                size: 30,
                                color: AppColors.secondary.shade900,
                              ),
                              inactiveIcon: Icon(
                                AppIcons.group_senior,
                                size: 30,
                                color: Colors.grey.shade300,
                              ),
                              isActive: activeTab == OrganizerScreenTab.volunteers,
                              onPressed: () {
                                context.bloc<OrganiserTabBloc>().add(TabChanged(OrganizerScreenTab.volunteers));
                              },
                            ),
                          ),
                        ],
                      ),
                      height: kToolbarHeight,
                    ),
                  ),
                ),
              ],
            ),
            body: IndexedStack(
              index: activeTab == OrganizerScreenTab.home ? 0 : 1,
              children: <Widget>[
                const OrganizerHomeTab(),
                const VolunteersListTabScreen(),
              ],
            ),
          );
        });
      });
    });
  }
}

import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/participants/participants_bloc_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/participants/participants_bloc_state.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organiser_screen_tab_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organiser_screen_tab_event.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organizer_screen_tab.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/volunteers/bloc.dart';
import 'package:attendance_tracka/src/widgets/app_bar.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'acount_menu_button.dart';

class OrganizerHomeTab extends StatefulWidget {
  const OrganizerHomeTab({
    Key key,
  }) : super(key: key);

  @override
  _OrganizerHomeTabState createState() => _OrganizerHomeTabState();
}

class _OrganizerHomeTabState extends State<OrganizerHomeTab> with TickerProviderStateMixin {
  AnimationController _animationController;
  VolunteersBloc organizerBloc;
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
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return BlocBuilder<VolunteersBloc, VolunteersState>(builder: (context, organiserState) {
        return BlocBuilder<ParticipantsBloc, ParticipantsState>(builder: (context, participantstate) {
          final textTheme = Theme.of(context).textTheme;
          final user = appState.currentUser;

          return Scaffold(
            appBar: AppAppBar(
              title: 'HOME',
              actions: <Widget>[
                const MenuButton(),
              ],
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: AppPaddings.bodyH,
                        child: Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                            Expanded(
                              child: Container(
                                child: StaggeredAnimatedColumn(
                                  animationController: _animationController,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Welcome, ',
                                        children: [
                                          TextSpan(
                                              text: "${user?.userName ?? ''}! ",
                                              style: TextStyle(fontWeight: FontWeight.w900)),
                                          TextSpan(
                                            text: "We should put a nice message here or something!",
                                          ),
                                        ],
                                      ),
                                      style: textTheme.title,
                                    ),
                                    SizedBox(height: 32),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: AppPaddings.lA,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary.shade100.withOpacity(.3),
                                                borderRadius: AppBorderRadius.small_all,
                                                boxShadow: []),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'INFO',
                                                  style: textTheme.title.copyWith(
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Divider(height: 24),
                                                Flexible(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        AppIcons.email,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'Email: ',
                                                          children: [
                                                            TextSpan(
                                                                text: "${user?.email ?? ''}.",
                                                                style: TextStyle(fontWeight: FontWeight.w900)),
                                                          ],
                                                        ),
                                                        style: textTheme.subtitle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                Flexible(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        AppIcons.account_square,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'Organisation Name: ',
                                                          children: [
                                                            TextSpan(
                                                                text: "${user?.userName ?? ''}",
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w900,
                                                                )),
                                                          ],
                                                        ),
                                                        style: textTheme.subtitle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    _BuildMeetupStats(),
                                    SizedBox(height: 16),
                                    _BuildVolunteers(),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}

class _BuildVolunteers extends StatelessWidget {
  const _BuildVolunteers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VolunteersBloc, VolunteersState>(builder: (context, volunteersState) {
      final textTheme = Theme.of(context).textTheme;
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: AppPaddings.lA,
        decoration: BoxDecoration(
          color: AppColors.primary.shade100.withOpacity(.3),
          borderRadius: AppBorderRadius.small_all,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'VOLUNTEERS',
              style: textTheme.title.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            Divider(height: 24),
            Flexible(
              child: Row(
                children: <Widget>[
                  Icon(
                    AppIcons.group_equal,
                    color: Colors.black,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text.rich(
                    TextSpan(
                      text: 'Total Volunteers: ',
                      children: [
                        TextSpan(
                            text: volunteersState.hasVolunteers ? "${volunteersState.volunteers.length}" : "-",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            )),
                      ],
                    ),
                    style: textTheme.subtitle,
                  ),
                  const Spacer(),
                  FlatButton(
                    child: Text('VIEW'),
                    onPressed: () {
                      context.bloc<OrganiserTabBloc>().add(TabChanged(OrganizerScreenTab.volunteers));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _BuildMeetupStats extends StatelessWidget {
  const _BuildMeetupStats({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantsBloc, ParticipantsState>(builder: (context, participantstate) {
      final textTheme = Theme.of(context).textTheme;
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: AppPaddings.lA,
        decoration: BoxDecoration(
          color: AppColors.primary.shade100.withOpacity(.3),
          borderRadius: AppBorderRadius.small_all,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'PARTICIPANTS',
              style: textTheme.title.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            Divider(height: 24),
            if (participantstate.hasMeetup)
              ...List.generate(participantstate.meetup.length, (index) {
                final meetup = participantstate.meetup[index];
                return Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: 'Day ${index + 1}',
                              children: [
                                TextSpan(
                                  text: "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            style: textTheme.title.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: 'Registered: ',
                              children: [
                                TextSpan(
                                  text: "${meetup.total}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            style: textTheme.subtitle,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Attended: ',
                              children: [
                                TextSpan(
                                  text: "${meetup.present}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            style: textTheme.subtitle,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Absent: ',
                              children: [
                                TextSpan(
                                  text: "${meetup.absent}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            style: textTheme.subtitle,
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
          ],
        ),
      );
    });
  }
}

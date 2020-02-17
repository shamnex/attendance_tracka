import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/volunteers/bloc.dart';
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
        final textTheme = Theme.of(context).textTheme;
        final user = appState.currentUser;

        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient.reversed.toList(),
                  ),
                  boxShadow: [
                    BoxShadow(color: AppColors.secondary.shade900.withOpacity(.4)),
                  ]),
              child: SafeArea(
                child: AppBar(
                  title: Text(
                    'HOME',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    const MenuButton(),
                  ],
                ),
              ),
            ),
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
                                      text: "${user?.userName ?? ''}! ", style: TextStyle(fontWeight: FontWeight.w900)),
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
                            Container(
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
                                                  text: organiserState.hasVolunteers
                                                      ? "${organiserState.volunteers.length}"
                                                      : "-",
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
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        );
      });
    });
  }
}

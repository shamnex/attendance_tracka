import 'dart:async';

import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/volunteers/bloc.dart';
import 'package:attendance_tracka/src/widgets/app_loading.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes.dart';
import 'acount_menu_button.dart';

class VolunteersListTabScreen extends StatefulWidget {
  const VolunteersListTabScreen({
    Key key,
  }) : super(key: key);

  @override
  _VolunteersListTabScreenState createState() => _VolunteersListTabScreenState();
}

class _VolunteersListTabScreenState extends State<VolunteersListTabScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  VolunteersBloc organizerBloc;
  AppBloc appBloc;
  Completer<bool> _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer<bool>();

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
      return BlocConsumer<VolunteersBloc, VolunteersState>(
          listenWhen: (prev, current) => prev.loading && !current.loading,
          listener: (context, organiserState) {
            if (!_refreshCompleter.isCompleted) {
              if ((organiserState.hasVolunteers || organiserState.hasError) && !organiserState.loading) {
                _refreshCompleter.complete();
              }
            }
            _refreshCompleter = Completer<bool>();
          },
          builder: (context, organiserState) {
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
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                        'VOLUNTEERS',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      actions: <Widget>[
                        AppIconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(OrganizerRoutes.addVolunteers);
                          },
                          icon: Icon(
                            AppIcons.user_add,
                            color: Colors.white,
                          ),
                        ),
                        MenuButton()
                      ],
                    ),
                  ),
                ),
                if (organiserState.hasError && !organiserState.hasVolunteers)
                  Expanded(
                    child: StaggeredAnimatedColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(),
                        Text(
                          'ERROR',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.error,
                          ),
                        ),
                        Padding(
                          padding: AppPaddings.lA,
                          child: Text(
                            organiserState.errorMessage,
                            style: textTheme.subtitle.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: AppButton(
                              onPressed: () {
                                organizerBloc.add(GetVolunteers(appState.currentUser, refresh: true));
                              },
                              child: Text('GET VOLUNTTERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                if (!organiserState.hasVolunteers && organiserState.loading)
                  Expanded(
                    child: AppSpinner(),
                  ),
                if (organiserState.hasVolunteers)
                  Expanded(
                      child: RefreshIndicator(
                    color: Colors.white70,
                    backgroundColor: AppColors.secondary,
                    onRefresh: () async {
                      organizerBloc.add(GetVolunteers(appState.currentUser, refresh: true));
                      return _refreshCompleter.future;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return VolunteerTile(volunteer: organiserState.volunteers[index]);
                      },
                      itemCount: organiserState.volunteers.length,
                    ),
                  )),
              ],
            );
          });
    });
  }
}

class VolunteerTile extends StatelessWidget {
  const VolunteerTile({
    Key key,
    @required this.volunteer,
  }) : super(key: key);

  final User volunteer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FlatButton(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.primary.shade100, width: .4)),
          color: Colors.transparent,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              AppIcons.account_circle,
              size: 30,
              color: AppColors.secondary,
            ),
            SizedBox(width: 16),
            Flexible(
              child: Text(
                volunteer.email,
                style: textTheme.subhead,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

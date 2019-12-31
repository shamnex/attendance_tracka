import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/widgets/blur_bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_app_bar.dart';

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({Key key, this.title, this.subhead, this.builder, this.loading = false, s})
      : super(key: key);

  final String title;
  final String subhead;
  final bool loading;
  final List<Widget> Function(AppMode) builder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
          final bool isVolunteer = appState.mode == AppMode.volunteer;
          final textTheme = Theme.of(context).textTheme;
          final theme = Theme.of(context);
          final mq = MediaQuery.of(context);
          return Scaffold(
            backgroundColor: theme.backgroundColor,
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  print(innerBoxIsScrolled);
                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: AuthAppBar(
                        maxHeight: mq.size.height * .3,
                        minHeight: kToolbarHeight,
                        isVolunteer: isVolunteer,
                        title: title,
                      ),
                    ),
                  ];
                },
                body: SafeArea(child: Builder(builder: (context) {
                  return Container(
                    padding: AppPaddings.body.copyWith(top: 25),
                    margin: EdgeInsets.only(top: 16),
                    width: mq.size.width,
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.t40,
                      color: AppColors.secondary,
                      gradient: LinearGradient(
                        colors: [
                          if (isVolunteer) Colors.white else AppColors.primary,
                          if (isVolunteer) Colors.white else AppColors.secondary.shade900,
                        ],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(.05),
                          offset: Offset(0, -30),
                          blurRadius: 30,
                        )
                      ],
                    ),
                    child: CustomScrollView(
                      shrinkWrap: true,
                      anchor: .4,
                      physics: NeverScrollableScrollPhysics(),
                      slivers: <Widget>[
                        SliverOverlapAbsorber(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            RichText(
                              text: TextSpan(
                                text: '$subhead ${isVolunteer ? 'a' : 'an'} ',
                                style: textTheme.title
                                    .copyWith(color: isVolunteer ? theme.textTheme.body1.color : Colors.white),
                                children: [
                                  TextSpan(
                                      text: isVolunteer ? 'Volunteer' : 'Organizer',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppBloc>(context)
                                    .add(AppModeChanged(mode: isVolunteer ? AppMode.organizer : AppMode.volunteer));
                              },
                              child: Text(
                                'Are you ${isVolunteer ? 'an Organizer' : 'a Volunteer'} ?',
                                style: textTheme.body1
                                    .copyWith(height: 1.7, color: isVolunteer ? theme.hintColor : Colors.white),
                              ),
                            ),
                            ...builder(appState.mode)
                          ]),
                        ),
                      ],
                    ),
                  );
                })),
              ),
            ),
          );
        }),
        if (loading)
          Positioned.fill(
            child: BluredBgWidget(
              child: Center(child: Text('Loading...')),
            ),
          )
      ],
    );
  }
}

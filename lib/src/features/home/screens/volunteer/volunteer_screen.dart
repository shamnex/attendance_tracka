import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/home/screens/mark_attendance/mark_attendance_route_argument.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/partials/acount_menu_button.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:attendance_tracka/src/widgets/app_bar.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerScreen extends StatefulWidget {
  final int iteration;
  const VolunteerScreen({Key key, this.iteration}) : super(key: key);

  @override
  _VolunteerScreenState createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      print(appState.iteration);
      final user = appState.currentUser;
      return Scaffold(
        appBar: AppAppBar(
          title: 'HOME',
          actions: <Widget>[
            const MenuButton(),
          ],
        ),
        body: Container(
          padding: AppPaddings.bodyH,
          child: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: 'Welcome, ',
                  children: [
                    TextSpan(text: "${user?.userName ?? ''}! ", style: TextStyle(fontWeight: FontWeight.w900)),
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
                                          text: "${user?.email ?? ''}.", style: TextStyle(fontWeight: FontWeight.w900)),
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
              const Spacer(),
              Stack(
                children: <Widget>[
                  AppButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.scan,
                          arguments: MarkAttendanceRouteArguments(
                              iteration: widget.iteration, apiURL: appState.currentUser.apiURL));
                    },
                    child: Text(
                      'MARK ATTENDANCE',
                      style: textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: 16,
                    child: Icon(AppIcons.qr_code, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 25),
            ]),
          ),
        ),
      );
    });
  }
}

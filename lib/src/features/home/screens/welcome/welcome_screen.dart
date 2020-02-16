import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Padding(
        padding: AppPaddings.bodyH,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const Spacer(),
              Expanded(
                child: StaggeredAnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      child: StaggeredAnimatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: Text(
                                'WELCOME!',
                                style: textTheme.display1.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: theme.brightness == Brightness.light ? Colors.black87 : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Are you an ',
                              style: textTheme.subhead,
                              children: [
                                TextSpan(
                                  text: 'Organizer ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextSpan(text: 'or a '),
                                TextSpan(
                                  text: 'Volunteer ?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: StaggeredAnimatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppButton(
                            onPressed: () {
                              BlocProvider.of<AppBloc>(context).add(AppModeChanged(mode: AppMode.organizer));
                              Navigator.of(context).pushNamed(AppRoutes.auth);
                            },
                            child: Text(
                              'ORGANIZER'.toUpperCase(),
                              style: textTheme.button.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 8),
                          AppButton.white(
                            onPressed: () {
                              BlocProvider.of<AppBloc>(context).add(AppModeChanged(mode: AppMode.volunteer));
                              Navigator.of(context).pushNamed(AppRoutes.auth);
                            },
                            child: Text(
                              'VOLUNTEER'.toUpperCase(),
                              style: textTheme.button.copyWith(color: Colors.black87),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.explanation);
                            },
                            child: Text(
                              'Help',
                              style: textTheme.caption.copyWith(height: 2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

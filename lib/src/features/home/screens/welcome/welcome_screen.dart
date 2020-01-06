import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
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
        padding: AppPaddings.body,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome!',
                      style: textTheme.display1.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.brightness == Brightness.light ? Colors.black87 : Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Are you an ',
                        style: textTheme.headline,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.explanation);
                      },
                      child: Text(
                        'What is this? 🧐',
                        style: textTheme.caption.copyWith(height: 2),
                      ),
                    ),
                    const Spacer(),
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
                    const Spacer(),
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

import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({Key key}) : super(key: key);

  @override
  _VolunteerScreenState createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      final user = appState.currentUser;
      return Container(
        padding: AppPaddings.body,
        child: Center(
          child: Column(children: <Widget>[
            const Spacer(),
            Text('Welcome ${user.email}'),
            SizedBox(height: 29),
            Text('Volunteer Screen'),
            const Spacer(),
            AppButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(Deauthenticate());
              },
              child: Text(
                'SIGN OUT',
                style: textTheme.button.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 25),
          ]),
        ),
      );
    });
  }
}

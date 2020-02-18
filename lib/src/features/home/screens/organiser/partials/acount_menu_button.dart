import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../service_locator.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 0.4,
      captureInheritedThemes: true,
      onSelected: (value) async {
        if (value == 'Sign Out') {
          final storage = sl.get<HydratedStorage>();
          await storage.clear();
          BlocProvider.of<AuthBloc>(context).add(Deauthenticate());
          BlocProvider.of<AppBloc>(context).add(HasOnboarded());
        }
      },
      icon: Icon(AppIcons.account_circle, color: Colors.white),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'Sign Out',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Sign Out'),
                Icon(AppIcons.sign_out),
              ],
            ),
          )
        ];
      },
    );
  }
}

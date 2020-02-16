import 'package:attendance_tracka/src/constants/icons.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 0.4,
      captureInheritedThemes: true,
      onSelected: (value) {
        if (value == 'Sign Out') {
          BlocProvider.of<AuthBloc>(context).add(Deauthenticate());
        }
      },
      icon: Icon(
        AppIcons.account_circle,
        color: Colors.white,
      ),
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

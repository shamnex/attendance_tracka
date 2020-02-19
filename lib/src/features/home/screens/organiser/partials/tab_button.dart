import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organiser_screen_tab_bloc.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/tab/organizer_screen_tab.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    Key key,
    @required this.isActive,
    @required this.onPressed,
    @required this.inactiveIcon,
    @required this.activeIcon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isActive;
  final Widget activeIcon;
  final Widget inactiveIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganiserTabBloc, OrganizerScreenTab>(builder: (context, tab) {
      return CupertinoButton(
          pressedOpacity: 0.9,
          onPressed: onPressed,
          child: AnimatedSwitcher(
            key: ValueKey(tab),
            duration: Duration(milliseconds: 100),
            child: SizedBox(
              child: isActive ? activeIcon : inactiveIcon,
            ),
          ));
    });
  }
}

import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppAppBar extends PreferredSize {
  AppAppBar({this.title, this.leading, this.actions});

  final String title;
  final List<Widget> actions;
  final Widget leading;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryGradient.reversed.toList(),
            ),
            boxShadow: [
              BoxShadow(color: AppColors.secondary.shade900.withOpacity(.4)),
            ]),
        child: SafeArea(
          child: AppBar(
              leading: leading,
              title: Text(
                title.toUpperCase() ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: actions),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum AppTheme {
  OrangeLight,
  OrangeDark,
}

final appThemeData = {
  AppTheme.OrangeLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
  ),
  AppTheme.OrangeDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange[700],
  ),
};

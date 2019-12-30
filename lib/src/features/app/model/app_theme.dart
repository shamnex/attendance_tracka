library app_theme;

import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'app_theme.g.dart';

class AppTheme extends EnumClass {
  static const AppTheme OrangeLight = _$OrangeLight;
  static const AppTheme OrangeDark = _$OrangeDark;

  const AppTheme._(String name) : super(name);

  static BuiltSet<AppTheme> get values => _$values;
  static AppTheme valueOf(String name) => _$valueOf(name);
  static Serializer<AppTheme> get serializer => _$appThemeSerializer;
}

final appThemeData = {
  AppTheme.OrangeLight: ThemeData(
    fontFamily: GoogleFonts.raleway().fontFamily,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
  ),
  AppTheme.OrangeDark: ThemeData(
    fontFamily: GoogleFonts.raleway().fontFamily,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary[700],
  ),
};

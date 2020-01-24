library app_theme;

import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
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

class AppInputTheme {
  const AppInputTheme._();

  static final outlineInputTheme = InputDecoration(
    hasFloatingPlaceholder: true,
    alignLabelWithHint: true,
    contentPadding: AppPaddings.body.copyWith(top: 16, bottom: 16),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBorderRadius.large_all,
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white70, width: 1),
      borderRadius: AppBorderRadius.large_all,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54, width: 1),
      borderRadius: AppBorderRadius.large_all,
    ),
    errorBorder:
        OutlineInputBorder(borderRadius: AppBorderRadius.large_all, borderSide: BorderSide(color: AppColors.error)),
    border: OutlineInputBorder(
      borderRadius: AppBorderRadius.large_all,
    ),
    filled: false,
    fillColor: AppColors.primary.shade50.withOpacity(.5),
    errorStyle: TextStyle(height: 2),
    hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w100),
  );
}

final appThemeData = {
  AppTheme.OrangeLight: ThemeData(
    fontFamily: GoogleFonts.raleway().fontFamily,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    backgroundColor: AppColors.background,
    inputDecorationTheme: InputDecorationTheme(
      hasFloatingPlaceholder: true,
      alignLabelWithHint: true,
      contentPadding: AppPaddings.body.copyWith(top: 16, bottom: 16),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.large_all,
        borderSide: BorderSide(
          color: AppColors.primary.shade100.withOpacity(.8),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary.shade50.withOpacity(.1)),
        borderRadius: AppBorderRadius.large_all,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary.shade200.withOpacity(.1)),
        borderRadius: AppBorderRadius.large_all,
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.large_all,
          borderSide: BorderSide(
            color: AppColors.error,
          )),
      border: OutlineInputBorder(
        borderRadius: AppBorderRadius.large_all,
      ),
      filled: true,
      fillColor: AppColors.primary.shade50.withOpacity(.5),
      errorStyle: TextStyle(height: 2),
      hintStyle: TextStyle(color: AppColors.hint, fontWeight: FontWeight.w100),
    ),
  ),
  //===================
  AppTheme.OrangeDark: ThemeData(
    fontFamily: GoogleFonts.raleway().fontFamily,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary[700],
    backgroundColor: AppColors.backgroundDark,
  ),
};

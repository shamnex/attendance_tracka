import 'dart:ui' show Color;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();
  static const MaterialColor primary = MaterialColor(
    _primaryColor,
    <int, Color>{
      50: Color(0xFFfdf2e6),
      100: Color(0xFFfae0bf),
      200: Color(0xFFfae0bf),
      300: Color(0xFFfae0bf),
      400: Color(0xFFfae0bf),
      500: Color(_primaryColor),
      600: Color(0xFFed8e26),
      700: Color(0xFFeb8320),
      800: Color(0xFFe46810),
      900: Color(0xFFe46810),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    _secondaryColor,
    <int, Color>{
      50: Color(0xFFeee8e0),
      100: Color(0xFFd5c5b3),
      200: Color(0xFFba9f80),
      300: Color(0xFF9e784d),
      400: Color(0xFF895b26),
      500: Color(_secondaryColor),
      600: Color(0xFF6c3800),
      700: Color(0xFF613000),
      800: Color(0xFF572800),
      900: Color(0xFF441b00),
    },
  );
  static const int _primaryColor = 0xFFEF962B;
  static const int _secondaryColor = 0xFF743E00;
  static const Color background = Color(0xFFEDEDED);
  static const Color backgroundDark = Color(0xff303030);
  static List<Color> primaryGradient = [primary, secondary.shade900];

  static const Color success = Color(0xFF009944);
  static const Color error = Color(0xFFFF7777);
  static const Color warning = Color(0xFFf0541e);
  static const Color information = Color(0xFF63c0df);
  static const Color hint = Color(0xFF959595);
}

///Colors Generated from http://mcg.mbitson.com/

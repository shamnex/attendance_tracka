import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppBorderRadius {
  const AppBorderRadius._();

  static const BorderRadius small_all = const BorderRadius.all(Radius.circular(8));
  static const BorderRadius small_top = const BorderRadius.only(
    topRight: Radius.circular(8),
    topLeft: Radius.circular(8),
  );
  static const BorderRadius small_bottom = const BorderRadius.only(
    topRight: Radius.circular(8),
    topLeft: Radius.circular(8),
  );

  //MEDIUM==========

  static const BorderRadius medium_all = const BorderRadius.all(Radius.circular(16));
  static const BorderRadius medium_top = const BorderRadius.only(
    topRight: Radius.circular(16),
    topLeft: Radius.circular(16),
  );
  static const BorderRadius medium_bottom = const BorderRadius.only(
    bottomRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
  );
  //LARGE==========
  static const BorderRadius large_all = const BorderRadius.all(Radius.circular(32));
  static const BorderRadius large_top = const BorderRadius.only(
    topRight: Radius.circular(32),
    topLeft: Radius.circular(32),
  );
  static const BorderRadius large_bottom = const BorderRadius.only(
    bottomRight: Radius.circular(32),
    bottomLeft: Radius.circular(32),
  );
}

///Colors Generated from http://mcg.mbitson.com/

import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppSnacks {
  static final List<Flushbar> _snacks = [];
  static showError(BuildContext context,
      {String message, Function onDissmiss, bool isSuccess = false, Duration duration}) async {
    final flushbar = Flushbar(
      message: message,
      isDismissible: true,
      boxShadows: [
        BoxShadow(
          color: AppColors.error.withOpacity(.4),
          blurRadius: 100,
        )
      ],
      backgroundGradient: LinearGradient(colors: [
        AppColors.warning,
        Colors.red,
        Colors.redAccent,
      ]),
      forwardAnimationCurve: Curves.ease,
      reverseAnimationCurve: Curves.ease,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppColors.error,
      animationDuration: const Duration(milliseconds: 600),
      duration: duration ?? const Duration(seconds: 7),
    );

    _snacks.add(flushbar);
    return flushbar.show(context).then((onValue) {
      if (onDissmiss != null) {
        onDissmiss();
      }
      _snacks.forEach((snack) => snack.dismiss());
    });

    // _showSnackbar(error.toString());
  }

  static Future showSuccess(context, {String message, bool isSuccess = false, Duration duration}) async {
    final flushbar = Flushbar(
      message: message,
      forwardAnimationCurve: Curves.ease,
      reverseAnimationCurve: Curves.ease,
      margin: EdgeInsets.zero,
      boxShadows: [
        BoxShadow(
          color: AppColors.success.withOpacity(.4),
          blurRadius: 100,
        )
      ],
      flushbarPosition: FlushbarPosition.TOP,
      backgroundGradient: LinearGradient(colors: [
        AppColors.success,
        Colors.green,
        Colors.greenAccent,
      ]),
      animationDuration: const Duration(milliseconds: 600),
      duration: duration ?? const Duration(seconds: 4),
    );

    _snacks.add(flushbar);
    return flushbar.show(context).then((onValue) => _snacks.forEach((snack) => snack.dismiss()));
  }
}

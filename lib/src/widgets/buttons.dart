import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final bool loading;

  AppButton({
    Key key,
    this.loading,
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        DecoratedBox(
          child: SizedBox(
            height: 20,
            width: 120,
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 30,
              spreadRadius: 10,
              color: AppColors.secondary,
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            child: SizedBox.expand(
              child: FlatButton(
                splashColor: Colors.transparent,
                onPressed: widget.onPressed,
                color: Colors.transparent,
                child: widget.child,
              ),
            ),
          ),
          height: kToolbarHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              gradient: LinearGradient(begin: Alignment(-1.0, 1.0), end: Alignment.bottomRight, colors: [
                AppColors.secondary,
                AppColors.primary,
                AppColors.primary,
              ])),
        ),
      ],
    );
  }
}

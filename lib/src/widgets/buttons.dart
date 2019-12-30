import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final bool loading;
  final bool _isWhite;

  AppButton.white({Key key, this.onPressed, this.child, this.loading})
      : _isWhite = true,
        super(key: key);

  AppButton({
    Key key,
    this.loading,
    this.onPressed,
    this.child,
  })  : _isWhite = false,
        super(key: key);

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
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            child: SizedBox.expand(
              child: FlatButton(
                splashColor: Colors.transparent,
                onPressed: widget.onPressed,
                color: widget._isWhite ? Colors.white : Colors.transparent,
                child: widget.child,
              ),
            ),
          ),
          height: kToolbarHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              gradient: widget._isWhite
                  ? null
                  : LinearGradient(begin: Alignment.topLeft.add(Alignment(.4, 0)), end: Alignment.bottomRight, colors: [
                      AppColors.secondary.shade900,
                      AppColors.primary,
                      AppColors.primary,
                    ])),
        ),
      ],
    );
  }
}

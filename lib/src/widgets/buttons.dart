import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';

import 'app_loading.dart';

class AppButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final bool loading;
  final bool _isWhite;
  final List<BoxShadow> boxShadow;

  const AppButton.white({Key key, this.onPressed, this.child, this.boxShadow, this.loading = false})
      : _isWhite = true,
        super(key: key);

  const AppButton({
    Key key,
    this.loading = false,
    this.onPressed,
    this.child,
    this.boxShadow,
  })  : _isWhite = false,
        super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          DecoratedBox(
            child: SizedBox(
              height: 10,
              width: 200,
            ),
            decoration: BoxDecoration(
                boxShadow: widget.boxShadow ??
                    [
                      BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 4,
                        color: AppColors.secondary.shade300,
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
                  onPressed: widget.loading ? null : widget.onPressed,
                  color: widget._isWhite ? Colors.white : Colors.transparent,
                  child: widget.loading
                      ? Center(
                          child: AppSpinner(
                            color: widget._isWhite ? AppColors.primary : Colors.white,
                          ),
                        )
                      : widget.child,
                ),
              ),
            ),
            height: kToolbarHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
                gradient: widget._isWhite
                    ? null
                    : LinearGradient(
                        begin: Alignment.topLeft.add(Alignment(.4, 0)),
                        end: Alignment.bottomRight,
                        colors: [
                            AppColors.secondary.shade900,
                            AppColors.primary,
                            AppColors.primary,
                          ])),
          ),
        ],
      ),
    );
  }
}

class AppIconButton extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final bool shadow;
  final bool loading;
  final Color backgroundColor;

  AppIconButton({
    Key key,
    this.loading,
    this.shadow = false,
    this.onPressed,
    this.backgroundColor,
    this.icon,
  }) : super(key: key);

  @override
  _AppIconButtonState createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        if (widget.shadow)
          DecoratedBox(
            child: SizedBox(
              height: kToolbarHeight / 2,
              width: kToolbarHeight / 2,
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 30,
                spreadRadius: 10,
                offset: Offset(10, 0),
                color: AppColors.secondary,
              )
            ]),
          ),
        Container(
          height: kToolbarHeight,
          width: kToolbarHeight,
          alignment: Alignment.center,
          child: IconButton(
            onPressed: widget.onPressed,
            color: widget.backgroundColor ?? Colors.transparent,
            icon: widget.icon,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
        ),
      ],
    );
  }
}

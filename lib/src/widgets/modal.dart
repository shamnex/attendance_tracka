import 'dart:ui';

import 'package:flutter/material.dart';

Future<T> showBluredModal<T>(
  BuildContext context, {
  Widget child,
  double height,
  bool dismissible = true,
  bool blur = false,
  EdgeInsets padding,
  BoxConstraints constraints,
  List<BoxShadow> boxShadow,
  Color backgroundColor = Colors.black45,
  bool barrierDismissble = true,
}) async {
  return Navigator.of(context).push(
    _CupertinoModalPopupRoute<T>(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => dismissible,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              height: height ?? 400,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: padding ?? EdgeInsets.all((26)),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      backgroundColor: backgroundColor,
      blur: blur,
      barrierLabel: 'Dismiss',
      barrierDismissble: barrierDismissble,
    ),
  );
}

class _CupertinoModalPopupRoute<T> extends PopupRoute<T> {
  _CupertinoModalPopupRoute({
    this.builder,
    this.barrierLabel,
    this.barrierDismissble,
    this.blur,
    this.backgroundColor,
    RouteSettings settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final bool barrierDismissble;
  final bool blur;
  final Color backgroundColor;

  @override
  final String barrierLabel;
  @override
  Color get barrierColor => backgroundColor ?? Colors.black45;

  @override
  bool get barrierDismissible => true;

  @override
  bool get semanticsDismissible => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 700);

  Animation<double> _animation;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    );

    return _animation;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        if (blur)
          GestureDetector(
            onTap: barrierDismissble && _animation.isCompleted ? () => Navigator.pop(context) : null,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: animation.value * 4, sigmaY: animation.value * 4),
              child: const Material(
                color: Colors.transparent,
                child: SizedBox.expand(),
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(
              CurvedAnimation(
                curve: Interval(
                  0.5,
                  1.0,
                  curve: Curves.easeInOut,
                ),
                reverseCurve: Interval(
                  0.9,
                  1.0,
                  curve: Curves.easeInOut,
                ),
                parent: _animation,
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(
                CurvedAnimation(
                  curve: Interval(.5, 1.0, curve: Curves.easeInOut),
                  parent: _animation,
                ),
              ),
              child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        .0,
                        1.0,
                        curve: Curves.ease,
                      ),
                      parent: _animation,
                    ),
                  ),
                  child: child),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class BluredBgWidget extends StatelessWidget {
  const BluredBgWidget({
    Key key,
    this.padding,
    this.height,
    this.child,
    this.backgroundColor,
    this.sigmaX = 6,
    this.sigmaY = 6,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final double height;
  final double sigmaX, sigmaY;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      height: height,
      width: mq.size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: LimitedBox(
                child: Container(
                  width: mq.size.width,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Container(
            color: backgroundColor ?? Colors.transparent,
            width: mq.size.width,
            child: child,
          ),
        ],
      ),
    );
  }
}

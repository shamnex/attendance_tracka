import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({
    Key key,
    this.color,
    this.width = 30,
    this.height = 30,
    this.padding,
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(maxHeight: height, minHeight: height),
        child: Center(
          child: SizedBox(
            width: width ?? 30,
            height: height ?? 30,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(color ?? Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

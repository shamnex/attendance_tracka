import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child ?? SizedBox.expand(),
        Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: AppColors.primary.shade100.withOpacity(.06),
          highlightColor: Colors.white,
          child: SizedBox.expand(
            child: Container(
              child: SizedBox(),
              color: AppColors.primary.shade100.withOpacity(.3),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ],
    );
  }
}

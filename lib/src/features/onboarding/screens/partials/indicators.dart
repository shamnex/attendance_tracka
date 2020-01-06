import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildIndicators extends StatelessWidget {
  const BuildIndicators({
    Key key,
    this.itemCount,
    this.activeItem,
    this.radius,
  })  : assert(activeItem <= itemCount),
        super(key: key);

  final int itemCount;
  final int activeItem;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(right: radius ?? 10),
          height: radius ?? 10,
          width: radius ?? 10,
          decoration: BoxDecoration(
            color: index == activeItem ? AppColors.primary : AppColors.primary.shade100,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

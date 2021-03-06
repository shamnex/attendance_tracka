import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AuthAppBar extends SliverPersistentHeaderDelegate {
  AuthAppBar({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.title,
    @required this.lightBG,
  });
  final double minHeight;
  final double maxHeight;
  final String title;
  final bool lightBG;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final scrolledToTop = !((maxHeight - shrinkOffset) >= minHeight);

    return SizedBox.expand(
      child: Container(
        padding: AppPaddings.bodyH.copyWith(
          bottom: 16 * ((shrinkOffset / maxHeight).clamp(0.5, 1.0)),
          top: 16 * ((shrinkOffset / maxHeight).clamp(0.5, 1.0)),
        ),
        decoration: BoxDecoration(
          color:
              scrolledToTop ? Colors.white.withOpacity((shrinkOffset / maxHeight).clamp(0.5, 1.0)) : Colors.transparent,
          gradient: scrolledToTop && !lightBG
              ? null
              : LinearGradient(
                  colors: AppColors.primaryGradient.reversed.toList(),
                ),
          boxShadow: [
            if (scrolledToTop)
              BoxShadow(
                color: AppColors.secondary.shade900.withOpacity((shrinkOffset / maxHeight).clamp(0.0, .2)),
                blurRadius: 20.0 * (shrinkOffset / maxHeight).clamp(0.0, 1.0),
              ),
          ],
        ),
        alignment: Alignment.bottomLeft,
        child: FittedBox(
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: textTheme.display1.copyWith(
                fontWeight: FontWeight.w900,
                color: scrolledToTop && lightBG ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(AuthAppBar oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || title != oldDelegate.title;
  }
}

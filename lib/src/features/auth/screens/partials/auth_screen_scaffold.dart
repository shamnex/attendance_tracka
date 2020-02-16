import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/widgets/app_loading.dart';
import 'package:attendance_tracka/src/widgets/blur_bg_widget.dart';
import 'package:flutter/material.dart';

import 'auth_app_bar.dart';

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({Key key, this.title, this.builder, this.appBar, this.loading = false, this.lightBG = false})
      : super(key: key);

  final String title;
  final bool loading;
  final bool lightBG;
  final AuthAppBar appBar;
  final Widget Function(bool lightBG) builder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.backgroundColor,
          body: SafeArea(
            child: NestedScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: appBar ??
                        AuthAppBar(
                          maxHeight: mq.size.height * .3,
                          minHeight: kToolbarHeight,
                          lightBG: lightBG,
                          title: title,
                        ),
                  ),
                ];
              },
              body: SafeArea(child: Builder(builder: (context) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: AppPaddings.bodyH.copyWith(top: 25),
                  margin: EdgeInsets.only(top: 16),
                  width: mq.size.width,
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.large_top,
                    color: AppColors.secondary,
                    gradient: LinearGradient(
                      colors: [
                        if (lightBG) Colors.white else AppColors.primary,
                        if (lightBG) Colors.white else AppColors.secondary.shade900,
                      ],
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(.05),
                        offset: Offset(0, -30),
                        blurRadius: 30,
                      )
                    ],
                  ),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    anchor: .4,
                    physics: NeverScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      builder(lightBG),
                    ],
                  ),
                );
              })),
            ),
          ),
        ),
        if (loading)
          Positioned.fill(
            child: BluredBgWidget(
              child: Center(
                  child: AppSpinner(
                color: AppColors.primary,
              )),
            ),
          )
      ],
    );
  }
}

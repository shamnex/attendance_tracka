import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  PageController pageController;
  double pageOffset = 0;
  int activeIndex = 0;
  final onBoardTexts = [
    ' ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam ',
    ', quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
    'Duis aute irure dolor in reprehenderit in voluptate velit'
  ];

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page); //<-- add listener and set state
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: true,
      create: (_) => pageController,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
              child: Center(
                child: Text(
                  'TRACKA',
                  style: Theme.of(context).textTheme.body2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                controller: pageController,
                children: <Widget>[
                  ...List.generate(
                      onBoardTexts.length,
                      (index) => _OnboardCard(
                            offset: pageOffset - index,
                            text: onBoardTexts[index],
                          ))
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Spacer(),
                _BuildIndicators(
                  activeItem: activeIndex,
                  itemCount: onBoardTexts.length,
                ),
                const Spacer(),
                AppButton(
                  onPressed: () {
                    BlocProvider.of<AppBloc>(context).add(ThemeChanged(theme: AppTheme.OrangeLight));
                  },
                  child: Text(
                    'Get Started'.toUpperCase(),
                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                  ),
                ),
                const Spacer(),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.button.copyWith(color: AppColors.secondary.shade200),
                  ),
                ),
                const Spacer(),
              ],
            )),
          ],
        ),
      )),
    );
  }
}

class _OnboardCard extends StatefulWidget {
  final String text;
  const _OnboardCard({Key key, this.text, this.offset}) : super(key: key);
  final double offset;

  @override
  __OnboardCardState createState() => __OnboardCardState();
}

class __OnboardCardState extends State<_OnboardCard> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation fade;
  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 1),
      vsync: this,
    );
    fade = Tween(begin: 0.0, end: 1.0).animate(animationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animationController.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((widget.offset.abs() - 0.5), 2) / 0.08));
    double scale = (1 - (widget.offset.abs() * .5)).clamp(0.8, 1.0);
    animationController.forward();

    return Transform.scale(
      scale: Curves.easeInOut.transform(scale),
      child: Transform.translate(
        offset: Offset(-80 * Curves.easeIn.transform(gauss) * widget.offset.sign, 0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        color: AppColors.primary.shade900,
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40, left: 8, right: 9),
                    decoration: BoxDecoration(
                      color: AppColors.primary.shade50,
                      borderRadius: BorderRadius.circular(16), //<--custom shape
                    ),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            //<--clipping image
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            child: SizedBox()),
                        SizedBox(height: 8),
                        Expanded(
                          child: SizedBox.expand(), //<-- will be replaced soon :)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text(
                'Keep track of loLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation,',
                style: Theme.of(context).textTheme.body2,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildIndicators extends StatelessWidget {
  const _BuildIndicators({
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

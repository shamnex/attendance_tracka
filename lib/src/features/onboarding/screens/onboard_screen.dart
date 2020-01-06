import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/onboarding/screens/partials/indicators.dart';
import 'package:attendance_tracka/src/features/onboarding/screens/partials/onboard_card.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen();
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
              height: MediaQuery.of(context).size.height * .1,
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
              height: MediaQuery.of(context).size.height * .65,
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
                      (index) => OnboardCard(
                            offset: pageOffset - index,
                            text: onBoardTexts[index],
                          ))
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                BuildIndicators(
                  activeItem: activeIndex,
                  itemCount: onBoardTexts.length,
                ),
                const Spacer(),
                Padding(
                  padding: AppPaddings.body,
                  child: AppButton(
                    onPressed: () {
                      BlocProvider.of<AppBloc>(context).add(HasOnboarded());
                    },
                    child: Text(
                      'Get Started'.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                FlatButton(
                  onPressed: () {
                    BlocProvider.of<AppBloc>(context).add(HasOnboarded());
                  },
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

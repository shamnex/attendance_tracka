import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.body,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              Text(
                'Explanation',
                style: textTheme.display1.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.brightness == Brightness.light ? Colors.black87 : Colors.white,
                ),
              ),
              SizedBox(height: 25),
              RichText(
                text: TextSpan(
                    text: 'A Volunteer : ',
                    style: textTheme.subhead.copyWith(fontWeight: FontWeight.w900),
                    children: [
                      TextSpan(
                          style: TextStyle(fontWeight: FontWeight.w300),
                          text:
                              'loLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation,loLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitations')
                    ]),
              ),
              SizedBox(height: 25),
              RichText(
                text: TextSpan(
                    text: 'An Organizer : ',
                    style: textTheme.subhead.copyWith(fontWeight: FontWeight.w900),
                    children: [
                      TextSpan(
                          style: TextStyle(fontWeight: FontWeight.w300),
                          text:
                              'loLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation,loLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitations')
                    ]),
              ),
              const Spacer(),
              AppButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'GO BACK',
                  style: textTheme.button.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

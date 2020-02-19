import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/widgets/app_back_button.dart';
import 'package:attendance_tracka/src/widgets/app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppAppBar(
        title: 'HELP',
        leading: AppBackButton(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.bodyH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
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
              Divider(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Attendance Tracka by: ",
                    style: textTheme.subhead.copyWith(fontWeight: FontWeight.w300),
                    children: [
                      TextSpan(
                        text: '@tejuafonja ,',
                        style: TextStyle(color: AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = 'https://twitter.com';
                            await launch('$url/tejuafonja');
                          },
                      ),
                      TextSpan(
                        text: ' @kennydukor ',
                        style: TextStyle(color: AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = 'https://twitter.com';
                            await launch('$url/kennydukor');
                          },
                      ),
                      TextSpan(text: 'and '),
                      TextSpan(
                        text: '@shamnex',
                        style: TextStyle(color: AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = 'https://twitter.com';
                            await launch('$url/shamnex');
                          },
                      ),
                    ]),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

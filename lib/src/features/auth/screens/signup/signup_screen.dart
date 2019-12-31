import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
        key: _formKey,
        child: AuthScreenScaffold(
            title: 'Sign Up',
            subhead: 'Signing you up as',
            builder: (appMode) {
              final bool isVolunteer = appMode == AppMode.volunteer;
              final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;

              return <Widget>[
                SizedBox(height: 30),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // autofocus: true,
                    style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                    decoration: !isVolunteer
                        ? AppInputTheme.outlineInputThem.copyWith(hintText: 'Organization')
                        : InputDecoration(
                            hintText: 'Organization',
                            filled: isVolunteer ? true : false,
                            hintStyle: TextStyle(
                              color: isVolunteer ? AppColors.hint : Colors.white,
                            ),
                          )),
                SizedBox(height: 16),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // autofocus: true,
                    style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                    decoration: !isVolunteer
                        ? AppInputTheme.outlineInputThem.copyWith(hintText: 'Email')
                        : InputDecoration(
                            hintText: 'Email',
                            filled: isVolunteer ? true : false,
                            hintStyle: TextStyle(
                              color: isVolunteer ? AppColors.hint : Colors.white,
                            ),
                          )),
                SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                  decoration: !isVolunteer
                      ? AppInputTheme.outlineInputThem.copyWith(hintText: 'Password')
                      : InputDecoration(
                          hintText: 'Password',
                          filled: isVolunteer ? true : false,
                          hintStyle: TextStyle(
                            color: isVolunteer ? AppColors.hint : Colors.white,
                          ),
                        ),
                ),
                SizedBox(height: 30),
                if (isVolunteer)
                  AppButton(
                    onPressed: () {},
                    child: Text(
                      'SIGN UP'.toUpperCase(),
                      style: textTheme.button.copyWith(color: Colors.white),
                    ),
                  )
                else
                  AppButton.white(
                    onPressed: () {},
                    child: Text(
                      'SIGN UP'.toUpperCase(),
                      style: textTheme.button.copyWith(color: isVolunteer ? Colors.white : textTheme.body1.color),
                    ),
                  ),
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AuthRoutes.login);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                          style: textTheme.body2.copyWith(color: modeColor),
                          text: 'Already have an accoun? ',
                          children: [
                            TextSpan(
                                text: 'Sign in!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isVolunteer ? AppColors.secondary : Colors.white))
                          ]),
                    ),
                  ),
                ),
              ];
            }));
  }

  _signup(context) {}
}

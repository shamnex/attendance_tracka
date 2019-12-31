import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignupBloc signupBloc;
  @override
  void initState() {
    signupBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
        key: _formKey,
        child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
          return AuthScreenScaffold(
              title: 'Sign Up',
              loading: state.loading,
              subhead: 'Signing you up as',
              builder: (appMode) {
                final bool isVolunteer = appMode == AppMode.volunteer;
                final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;

                return <Widget>[
                  SizedBox(height: 30),
                  TextFormField(
                      onChanged: (value) => signupBloc.add(OrganizationChanged(value)),
                      validator: (value) => InputValidators.minLength(value, min: 3),
                      keyboardType: TextInputType.emailAddress,
                      // autofocus: true,
                      style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                      decoration: !isVolunteer
                          ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Organization')
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
                    onChanged: (value) => signupBloc.add(EmailChanged(value)),
                    validator: InputValidators.email,
                    // autofocus: true,
                    style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                    decoration: !isVolunteer
                        ? AppInputTheme.outlineInputTheme.copyWith(
                            hintText: 'Email',
                          )
                        : InputDecoration(
                            hintText: 'Email',
                            filled: isVolunteer ? true : false,
                            hintStyle: TextStyle(
                              color: isVolunteer ? AppColors.hint : Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => signupBloc.add(PasswordChanged(value)),
                    validator: (value) => InputValidators.minLength(value, min: 3),
                    style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                    decoration: !isVolunteer
                        ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Password')
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
                      onPressed: _signup,
                      child: Text(
                        'SIGN UP'.toUpperCase(),
                        style: textTheme.button.copyWith(color: Colors.white),
                      ),
                    )
                  else
                    AppButton.white(
                      onPressed: _signup,
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
              });
        }));
  }

  _signup() {
    if (_formKey.currentState.validate()) {
      signupBloc.add(SignUp());
    }
  }
}

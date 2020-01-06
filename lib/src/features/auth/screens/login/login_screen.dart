import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_bloc.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/login/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Form(
      key: _formKey,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loggedIn) {
            BlocProvider.of<AuthBloc>(context).add(Authenticate());
            BlocProvider.of<AppBloc>(context).add(HasLoggedUser(state.user));
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return AuthScreenScaffold(
              loading: state.loading,
              title: 'Sign In',
              builder: (appMode) {
                final bool isVolunteer = appMode == AppMode.volunteer;
                final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;
                return <Widget>[
                  RichText(
                    text: TextSpan(
                      text: 'Signing you in as ${isVolunteer ? 'a' : 'an'} ',
                      style: textTheme.title.copyWith(color: isVolunteer ? theme.textTheme.body1.color : Colors.white),
                      children: [
                        TextSpan(
                            text: isVolunteer ? 'Volunteer' : 'Organizer',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AppBloc>(context)
                          .add(AppModeChanged(mode: isVolunteer ? AppMode.organizer : AppMode.volunteer));
                    },
                    child: Text(
                      'Are you ${isVolunteer ? 'an Organizer' : 'a Volunteer'} ?',
                      style: textTheme.body1.copyWith(height: 1.7, color: isVolunteer ? theme.hintColor : Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidators.email,
                      onChanged: (value) => loginBloc.add(EmailChanged(value)),
                      autofocus: true,
                      style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                      decoration: !isVolunteer
                          ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Email')
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
                    validator: (value) => InputValidators.minLength(value, length: 6),
                    onChanged: (value) => loginBloc.add(PasswordChanged(value)),
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
                      onPressed: _login,
                      child: Text(
                        'SIGN IN'.toUpperCase(),
                        style: textTheme.button.copyWith(color: Colors.white),
                      ),
                    )
                  else
                    AppButton.white(
                      onPressed: _login,
                      child: Text(
                        'SIGN IN'.toUpperCase(),
                        style: textTheme.button.copyWith(color: isVolunteer ? Colors.white : textTheme.body1.color),
                      ),
                    ),
                  SizedBox(height: 8),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AuthRoutes.signup);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            style: textTheme.body2.copyWith(color: modeColor),
                            text: 'Don\'t have an accoun? ',
                            children: [
                              TextSpan(
                                  text: 'Sign up!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isVolunteer ? AppColors.secondary : Colors.white))
                            ]),
                      ),
                    ),
                  ),
                ];
              });
        }),
      ),
    );
  }

  _login() {
    if (_formKey.currentState.validate()) {
      final userType =
          BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer ? UserType.organizer : UserType.volunteer;
      loginBloc.add(Login(userType));
    }
  }
}

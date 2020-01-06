import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_bloc.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_event.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/routes/app_routes.dart';
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Form(
        key: _formKey,
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.isSignedUp) {
              BlocProvider.of<AuthBloc>(context).add(Authenticate());
              BlocProvider.of<AppBloc>(context).add(HasLoggedUser(state.user));
              if (BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer) {
                Navigator.of(context, rootNavigator: true)..pushReplacementNamed(AppRoutes.addVolunteer);
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          },
          child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
            return AuthScreenScaffold(
                title: 'Sign Up',
                loading: state.loading,
                builder: (appMode) {
                  final bool isVolunteer = appMode == AppMode.volunteer;
                  final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;

                  return <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Signing you up  as ${isVolunteer ? 'a' : 'an'} ',
                        style:
                            textTheme.title.copyWith(color: isVolunteer ? theme.textTheme.body1.color : Colors.white),
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
                        style:
                            textTheme.body1.copyWith(height: 1.7, color: isVolunteer ? theme.hintColor : Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                        autofocus: true,
                        onChanged: (value) => signupBloc.add(OrganizationChanged(value)),
                        validator: (value) => InputValidators.minLength(value, length: 3),
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
                    if (!isVolunteer)
                      TextFormField(
                          obscureText: false,
                          onChanged: (value) => signupBloc.add(UserNameChanged(value)),
                          validator: (value) => InputValidators.minLength(value, length: 6),
                          style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                          decoration: AppInputTheme.outlineInputTheme.copyWith(hintText: 'Organization Username')),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => signupBloc.add(EmailChanged(value)),
                      validator: InputValidators.email,
                      // autofocus: true,
                      style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                      decoration: !isVolunteer
                          ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Email')
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
                      validator: (value) => InputValidators.minLength(value, length: 3),
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
                    SizedBox(height: 16),
                    if (!isVolunteer)
                      TextFormField(
                          obscureText: false,
                          onChanged: (value) => signupBloc.add(ApiChanged(value)),
                          validator: (value) => InputValidators.minLength(value, length: 6),
                          style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                          decoration: AppInputTheme.outlineInputTheme.copyWith(hintText: 'Api URL')),
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
          }),
        ));
  }

  _signup() {
    if (_formKey.currentState.validate()) {
      final userType =
          BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer ? UserType.organizer : UserType.volunteer;
      signupBloc.add(SignUp(userType));
    }
  }
}

import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_bloc.dart';
import 'package:attendance_tracka/src/features/auth/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/login/bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/api_bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/check_volunteer_password_bloc/check_volunteer_password_bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/check_volunteer_password_bloc/check_volunteer_password_event.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/check_volunteer_password_bloc/check_volunteer_password_state.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/app_loading.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/snack_bar.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
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
    loginBloc = context.bloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final AppBloc appBloc = context.bloc();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocListener<GetApiUrlBloc, GetApiUrlState>(
          listener: (_, state) {
            if (state is SuccessState) {
              loginBloc.add(ApiChanged(state.apiURL));
            }
          },
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loggedIn) {
                appBloc.add(UserLoggedIn(state.user));
                if (appBloc.state.mode == AppMode.volunteer) {
                  appBloc.add(IterationChanged(state.iteration));
                }
                BlocProvider.of<AuthBloc>(context).add(Authenticate());
                Navigator.of(context, rootNavigator: true).maybePop();
              }
              if (state.hasError) {
                AppSnacks.showError(context, message: state.errorMessage);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return BlocBuilder<GetApiUrlBloc, GetApiUrlState>(builder: (context, getApiUrlState) {
                return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
                  return BlocBuilder<CheckVolunteerPasswordBloc, CheckVolunteerPasswordState>(
                      builder: (context, checkPasswordState) {
                    return AuthScreenScaffold(
                        loading: state.loading,
                        lightBG: appState.mode == AppMode.volunteer,
                        title: 'Sign In',
                        builder: (lightBG) {
                          final bool isVolunteer = appState.mode == AppMode.volunteer;
                          final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;
                          bool canGetVonteerApiURL = isVolunteer && getApiUrlState is SuccessState || !isVolunteer;
                          return SliverList(
                            delegate: SliverChildListDelegate([
                              RichText(
                                text: TextSpan(
                                  text: 'Signing you in as ${isVolunteer ? 'a' : 'an'} ',
                                  style: textTheme.title
                                      .copyWith(color: lightBG ? theme.textTheme.body1.color : Colors.white),
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
                                  appBloc
                                      .add(AppModeChanged(mode: !isVolunteer ? AppMode.volunteer : AppMode.organizer));
                                },
                                child: Text(
                                  'Are you ${isVolunteer ? 'an Organizer' : 'a Volunteer'} ?',
                                  style: textTheme.body1
                                      .copyWith(height: 1.7, color: lightBG ? theme.hintColor : Colors.white),
                                ),
                              ),
                              SizedBox(height: 30),
                              if (isVolunteer)
                                Padding(
                                  padding: AppPaddings.mV,
                                  child: TextFormField(
                                      initialValue: state.username,
                                      obscureText: false,
                                      onChanged: (value) {
                                        if (value.trim().isEmpty) return;
                                        if (isVolunteer) {
                                          BlocProvider.of<GetApiUrlBloc>(context)
                                              .add(GetOrganisationApiUrl(value.trim()));
                                        }
                                        loginBloc.add(UserNameChanged(value.trim()));
                                      },
                                      validator: (value) {
                                        return InputValidators.minLength(value, length: 6);
                                      },
                                      style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                                      decoration: !isVolunteer
                                          ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Organisation Username')
                                          : InputDecoration(
                                              suffixIcon: Builder(
                                                builder: (BuildContext context) {
                                                  if (getApiUrlState is LoadingState) {
                                                    return SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child: AppSpinner(width: 10, height: 10),
                                                    );
                                                  }
                                                  if (getApiUrlState is SuccessState) {
                                                    return SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: AppColors.success,
                                                      ),
                                                    );
                                                  }
                                                  return SizedBox();
                                                },
                                              ),
                                              hintText: 'Organisation Username',
                                              filled: isVolunteer ? true : false,
                                              hintStyle: TextStyle(
                                                color: isVolunteer ? AppColors.hint : Colors.white,
                                              ),
                                            )),
                                ),
                              if (isVolunteer)
                                Builder(
                                  builder: (context) {
                                    return AnimatedContainer(
                                      margin: EdgeInsets.symmetric(vertical: getApiUrlState is ErrorState ? 4 : 0),
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      height: getApiUrlState is ErrorState ? 18 : 0,
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 200),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 18,
                                            width: 2,
                                            color: AppColors.error,
                                          ),
                                          SizedBox(width: 4),
                                          if (getApiUrlState is ErrorState)
                                            Text(
                                              getApiUrlState?.error ?? 'No Organisation found',
                                              style: textTheme.caption.copyWith(
                                                color: AppColors.error,
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              Padding(
                                padding: AppPaddings.mV,
                                child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: InputValidators.email,
                                    enabled: isVolunteer ? getApiUrlState is SuccessState : true,
                                    onChanged: (value) {
                                      loginBloc.add(EmailChanged(value));
                                      if (isVolunteer && getApiUrlState is SuccessState) {
                                        BlocProvider.of<CheckVolunteerPasswordBloc>(context).add(CheckPassword(
                                          email: value.trim(),
                                          apiURL: getApiUrlState.apiURL,
                                        ));
                                      }
                                    },
                                    style: TextStyle(color: lightBG ? textTheme.body1.color : Colors.white),
                                    decoration: !lightBG
                                        ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Email')
                                        : InputDecoration(
                                            hintText: 'Email',
                                            filled: lightBG ? true : false,
                                            suffixIcon: Builder(
                                              builder: (BuildContext context) {
                                                if (checkPasswordState is CHVLoadingState) {
                                                  return SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: AppSpinner(width: 10, height: 10),
                                                  );
                                                }
                                                if (checkPasswordState is CHVSuccessState) {
                                                  return SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      color: AppColors.success,
                                                    ),
                                                  );
                                                }
                                                return SizedBox();
                                              },
                                            ),
                                            hintStyle: TextStyle(
                                              color: lightBG ? AppColors.hint : Colors.white,
                                            ),
                                          )),
                              ),
                              if (isVolunteer)
                                Builder(
                                  builder: (context) {
                                    return AnimatedContainer(
                                      margin:
                                          EdgeInsets.symmetric(vertical: checkPasswordState is CHVErrorState ? 4 : 0),
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      height: checkPasswordState is CHVErrorState ? 18 : 0,
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 200),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 18,
                                            width: 2,
                                            color: AppColors.error,
                                          ),
                                          SizedBox(width: 4),
                                          if (checkPasswordState is CHVErrorState)
                                            Text(
                                              checkPasswordState?.error ??
                                                  'User not found, kindly contact the Organiser',
                                              style: textTheme.caption.copyWith(
                                                color: AppColors.error,
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              if (isVolunteer
                                  ? checkPasswordState is CHVSuccessState && checkPasswordState.haspassword
                                  : true)
                                Padding(
                                  padding: AppPaddings.mV,
                                  child: TextFormField(
                                    obscureText: true,
                                    validator: (value) => InputValidators.minLength(value, length: 6),
                                    onChanged: (value) => loginBloc.add(PasswordChanged(value)),
                                    style: TextStyle(color: lightBG ? textTheme.body1.color : Colors.white),
                                    decoration: !lightBG
                                        ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Password')
                                        : InputDecoration(
                                            hintText: 'Password',
                                            filled: lightBG ? true : false,
                                            hintStyle: TextStyle(
                                              color: lightBG ? AppColors.hint : Colors.white,
                                            ),
                                          ),
                                  ),
                                )
                              else if (checkPasswordState is CHVSuccessState && !checkPasswordState.haspassword)
                                _BuildCreatePassword(
                                  textTheme: textTheme,
                                  loginBloc: loginBloc,
                                  lightBG: lightBG,
                                ),
                              if (lightBG)
                                Padding(
                                  padding: AppPaddings.mV,
                                  child: AppButton(
                                    onPressed: () => _login(checkPasswordState),
                                    child: Text(
                                      'SIGN IN'.toUpperCase(),
                                      style: textTheme.button.copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              else
                                Padding(
                                  padding: AppPaddings.mV,
                                  child: AppButton.white(
                                    onPressed: () => _login(checkPasswordState),
                                    child: Text(
                                      'SIGN IN'.toUpperCase(),
                                      style: textTheme.button
                                          .copyWith(color: lightBG ? Colors.white : textTheme.body1.color),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 8),
                              FlatButton(
                                onPressed: () {
                                  if (isVolunteer) {
                                    appBloc.add(AppModeChanged(mode: AppMode.organizer));
                                  }
                                  Navigator.of(context).pushReplacementNamed(AuthRoutes.signup);
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
                                                  color: lightBG ? AppColors.secondary : Colors.white))
                                        ]),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        });
                  });
                });
              });
            }),
          ),
        ),
      ),
    );
  }

  _login(CheckVolunteerPasswordState checkVolunteerPasswordState) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      if (BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer) {
        loginBloc.add(OrganizerLogin());
      } else {
        if (checkVolunteerPasswordState is CHVSuccessState) {
          loginBloc.add(VolunteerLogin(haspassword: checkVolunteerPasswordState.haspassword));
        }
      }
    }
  }
}

class _BuildCreatePassword extends StatelessWidget {
  const _BuildCreatePassword({
    Key key,
    @required this.textTheme,
    @required this.loginBloc,
    @required this.lightBG,
  }) : super(key: key);

  final TextTheme textTheme;
  final LoginBloc loginBloc;
  final bool lightBG;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return StaggeredAnimatedColumn(
        duration: Duration(milliseconds: 1000),
        children: <Widget>[
          Padding(
            padding: AppPaddings.mV,
            child: Text(
              'CREATE PASSWORD',
              style: textTheme.subtitle.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: AppPaddings.mV,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Seems you have not created your password, kindly complete the form below :)",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              style: textTheme.subtitle,
            ),
          ),
          Divider(height: 16),
          Padding(
            padding: AppPaddings.mV,
            child: TextFormField(
              obscureText: true,
              validator: (value) => InputValidators.minLength(value, length: 6),
              onChanged: (value) => loginBloc.add(PasswordChanged(value)),
              style: TextStyle(color: lightBG ? textTheme.body1.color : Colors.white),
              decoration: !lightBG
                  ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Password')
                  : InputDecoration(
                      hintText: 'Password',
                      filled: lightBG ? true : false,
                      hintStyle: TextStyle(
                        color: lightBG ? AppColors.hint : Colors.white,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: AppPaddings.mV,
            child: TextFormField(
              obscureText: true,
              validator: (value) {
                if (value != state.password) {
                  return 'Passwords does not match';
                }
                return InputValidators.minLength(value, length: 6);
              },
              style: TextStyle(color: lightBG ? textTheme.body1.color : Colors.white),
              decoration: !lightBG
                  ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Password')
                  : InputDecoration(
                      hintText: 'Confirm Password',
                      filled: lightBG ? true : false,
                      hintStyle: TextStyle(
                        color: lightBG ? AppColors.hint : Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      );
    });
  }
}

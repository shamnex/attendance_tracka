import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
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
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/app_loading.dart';
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
                BlocProvider.of<AppBloc>(context).add(UserLoggedIn(state.user));
                BlocProvider.of<AuthBloc>(context).add(Authenticate());
                Navigator.of(context, rootNavigator: true).maybePop();
              }
              if (state.hasError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large_all),
                ));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return BlocBuilder<GetApiUrlBloc, GetApiUrlState>(builder: (context, getApiUrlState) {
                return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
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
                                BlocProvider.of<AppBloc>(context)
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
                              TextFormField(
                                  initialValue: state.username,
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.trim().isEmpty) return;
                                    if (isVolunteer) {
                                      BlocProvider.of<GetApiUrlBloc>(context).add(GetOrganizationApiUrl(value.trim()));
                                    }
                                    loginBloc.add(UserNameChanged(value.trim()));
                                  },
                                  validator: (value) {
                                    return InputValidators.minLength(value, length: 6);
                                  },
                                  style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                                  decoration: !isVolunteer
                                      ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Organization Username')
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
                                          hintText: 'Organization Username',
                                          filled: isVolunteer ? true : false,
                                          hintStyle: TextStyle(
                                            color: isVolunteer ? AppColors.hint : Colors.white,
                                          ),
                                        )),
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
                            SizedBox(height: 16),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: InputValidators.email,
                                onChanged: (value) => loginBloc.add(EmailChanged(value)),
                                style: TextStyle(color: lightBG ? textTheme.body1.color : Colors.white),
                                decoration: !lightBG
                                    ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Email')
                                    : InputDecoration(
                                        hintText: 'Email',
                                        filled: lightBG ? true : false,
                                        hintStyle: TextStyle(
                                          color: lightBG ? AppColors.hint : Colors.white,
                                        ),
                                      )),
                            SizedBox(height: 16),
                            TextFormField(
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
                            SizedBox(height: 30),
                            if (lightBG)
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
                                  style:
                                      textTheme.button.copyWith(color: lightBG ? Colors.white : textTheme.body1.color),
                                ),
                              ),
                            SizedBox(height: 8),
                            FlatButton(
                              onPressed: () {
                                if (isVolunteer) {
                                  BlocProvider.of<AppBloc>(context).add(AppModeChanged(mode: AppMode.organizer));
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
            }),
          ),
        ),
      ),
    );
  }

  _login() {
    if (_formKey.currentState.validate()) {
      if (BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer) {
        loginBloc.add(OrganizerLogin());
      } else {
        loginBloc.add(VolunteerLogin());
      }
    }
  }
}

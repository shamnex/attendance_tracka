import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_bloc.dart';
import 'package:attendance_tracka/src/features/auth/bloc/auth_event.dart';
import 'package:attendance_tracka/src/features/auth/routes/auth_routes.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/api_bloc/bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/app_loading.dart';
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

    return Scaffold(
      body: Form(
          key: _formKey,
          child: BlocListener<GetApiUrlBloc, GetApiUrlState>(
            listener: (_, state) {
              if (state is SuccessState) {
                signupBloc.add(ApiChanged(state.apiURL));
              }
            },
            child: BlocListener<SignupBloc, OrganizerSignupState>(
              listener: (context, state) {
                if (state.isSignedUp) {
                  BlocProvider.of<AuthBloc>(context).add(Authenticate());
                  BlocProvider.of<AppBloc>(context).add(UserLoggedIn(state.user));
                  Navigator.of(context, rootNavigator: true).pop();
                }
                if (state.hasError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large_all),
                  ));
                }
              },
              child: BlocBuilder<SignupBloc, OrganizerSignupState>(builder: (context, state) {
                return BlocBuilder<GetApiUrlBloc, GetApiUrlState>(builder: (context, getApiUrlState) {
                  return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
                    return AuthScreenScaffold(
                        title: 'Sign Up',
                        lightBG: appState.mode == AppMode.volunteer,
                        loading: state.loading,
                        builder: (lightBG) {
                          final bool isVolunteer = appState.mode == AppMode.volunteer;
                          final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;
                          bool canGetVonteerApiURL = isVolunteer && getApiUrlState is SuccessState || !isVolunteer;
                          return SliverList(
                            delegate: SliverChildListDelegate([
                              RichText(
                                text: TextSpan(
                                  text: 'Signing you up as ${isVolunteer ? 'a' : 'an'} ',
                                  style: textTheme.title
                                      .copyWith(color: isVolunteer ? theme.textTheme.body1.color : Colors.white),
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
                                  Navigator.of(context).pushReplacementNamed(AuthRoutes.login);
                                },
                                child: Text(
                                  'Are you ${isVolunteer ? 'an Organizer' : 'a Volunteer'} ?',
                                  style: textTheme.body1
                                      .copyWith(height: 1.7, color: isVolunteer ? theme.hintColor : Colors.white),
                                ),
                              ),
                              SizedBox(height: 30),
                              if (!isVolunteer)
                                TextFormField(
                                    initialValue: state.organization,
                                    onChanged: (value) => signupBloc.add(OrganizationChanged(value)),
                                    validator: (value) => InputValidators.minLength(value, length: 3),
                                    keyboardType: TextInputType.emailAddress,
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
                                  initialValue: state.organizationUserName,
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.trim().isEmpty) return;
                                    if (isVolunteer) {
                                      BlocProvider.of<GetApiUrlBloc>(context).add(GetOrganizationApiUrl(value.trim()));
                                    }
                                    signupBloc.add(UserNameChanged(value.trim()));
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
                                                  child: AppSpinner(
                                                    width: 10,
                                                    height: 10,
                                                  ),
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
                                initialValue: state.email,
                                enabled: canGetVonteerApiURL,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => signupBloc.add(EmailChanged(value)),
                                validator: InputValidators.email,
                                style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                                decoration: !isVolunteer
                                    ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Email')
                                    : InputDecoration(
                                        hintText: 'Email',
                                        filled: isVolunteer ? true : false,
                                        errorStyle: TextStyle(color: Colors.red),
                                        hintStyle: TextStyle(
                                          color: isVolunteer
                                              ? canGetVonteerApiURL ? AppColors.hint : AppColors.hint.withOpacity(.3)
                                              : Colors.white,
                                        ),
                                      ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: state.password,
                                enabled: canGetVonteerApiURL,
                                obscureText: true,
                                onChanged: (value) => signupBloc.add(PasswordChanged(value)),
                                validator: (value) => InputValidators.minLength(value, length: 3),
                                style: TextStyle(color: isVolunteer ? textTheme.body1.color : Colors.white),
                                decoration: !isVolunteer
                                    ? AppInputTheme.outlineInputTheme.copyWith(hintText: 'Password')
                                    : InputDecoration(
                                        hintText: 'Password',
                                        filled: isVolunteer ? true : false,
                                        errorStyle: TextStyle(color: Colors.red),
                                        hintStyle: TextStyle(
                                          color: isVolunteer
                                              ? canGetVonteerApiURL ? AppColors.hint : AppColors.hint.withOpacity(.3)
                                              : Colors.white,
                                        ),
                                      ),
                              ),
                              SizedBox(height: 16),
                              if (!isVolunteer)
                                TextFormField(
                                    validator: (value) => InputValidators.isURL(value),
                                    obscureText: false,
                                    onChanged: (value) => signupBloc.add(ApiChanged(value)),
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
                                    style: textTheme.button
                                        .copyWith(color: isVolunteer ? Colors.white : textTheme.body1.color),
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
                            ]),
                          );
                        });
                  });
                });
              }),
            ),
          )),
    );
  }

  _signup() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      final userType =
          BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer ? UserType.organizer : UserType.volunteer;
      signupBloc.add(SignUp(userType));
    }
  }
}

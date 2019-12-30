import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/constants/paddings.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
        key: _formKey,
        child: AuthScreenScaffold(
            title: 'Sign In',
            subhead: 'Signing you in as',
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
                      'SIGN IN'.toUpperCase(),
                      style: textTheme.button.copyWith(color: Colors.white),
                    ),
                  )
                else
                  AppButton.white(
                    onPressed: () {},
                    child: Text(
                      'SIGN IN'.toUpperCase(),
                      style: textTheme.button.copyWith(color: isVolunteer ? Colors.white : textTheme.body1.color),
                    ),
                  ),
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () {},
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
            }));
  }
}

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({
    Key key,
    this.title,
    this.subhead,
    this.builder,
  }) : super(key: key);

  final String title;
  final String subhead;
  final List<Widget> Function(AppMode) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      final bool isVolunteer = appState.mode == AppMode.volunteer;
      final textTheme = Theme.of(context).textTheme;
      final theme = Theme.of(context);
      final mq = MediaQuery.of(context);
      return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScroller) {
              return [
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    maxHeight: mq.size.height * .3,
                    minHeight: kToolbarHeight,
                    child: Container(
                      padding: AppPaddings.body.copyWith(bottom: 25),
                      alignment: Alignment.bottomLeft,
                      child: FittedBox(
                        child: Text(
                          title,
                          style: textTheme.display1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.light ? Colors.black87 : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SafeArea(child: Builder(builder: (context) {
              return Container(
                padding: AppPaddings.body.copyWith(top: 25),
                width: mq.size.width,
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.t40,
                  color: AppColors.secondary,
                  gradient: LinearGradient(
                    colors: [
                      if (isVolunteer) Colors.white else AppColors.primary,
                      if (isVolunteer) Colors.white else AppColors.secondary.shade900,
                    ],
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(.05),
                      offset: Offset(0, -30),
                      blurRadius: 30,
                    )
                  ],
                ),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        RichText(
                          text: TextSpan(
                            text: '$subhead ${isVolunteer ? 'a' : 'an'} ',
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
                          },
                          child: Text(
                            'Are you ${isVolunteer ? 'an Organizer' : 'a Volunteer'} ?',
                            style: textTheme.body1
                                .copyWith(height: 1.7, color: isVolunteer ? theme.hintColor : Colors.white),
                          ),
                        ),
                        ...builder(appState.mode)
                      ]),
                    ),
                  ],
                ),
              );
            })),
          ),
        ),
      );
    });
  }
}

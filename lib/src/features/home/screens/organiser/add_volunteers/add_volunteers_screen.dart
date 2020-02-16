import 'package:attendance_tracka/src/constants/border_radius.dart';
import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_app_bar.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/modal.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_volunteers_bloc.dart';
import 'bloc/bloc.dart';

class AddVolunteersScreen extends StatefulWidget {
  const AddVolunteersScreen({Key key}) : super(key: key);

  @override
  _AddVolunteersScreenState createState() => _AddVolunteersScreenState();
}

class _AddVolunteersScreenState extends State<AddVolunteersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddVolunteersBloc bloc;
  TextEditingController emailEditingController;
  @override
  void initState() {
    emailEditingController = TextEditingController();
    bloc = BlocProvider.of<AddVolunteersBloc>(context);
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    emailEditingController.dispose();
    bloc.add(Reset());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: BlocListener<AddVolunteersBloc, AddVolunteersState>(
        listener: (context, state) {},
        child: BlocBuilder<AddVolunteersBloc, AddVolunteersState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                AuthScreenScaffold(
                    lightBG: true,
                    loading: state is LoadingState,
                    appBar: AuthAppBar(
                      maxHeight: 200,
                      minHeight: kToolbarHeight,
                      lightBG: true,
                      title: 'Add Volunteers',
                    ),
                    builder: (appMode) {
                      return SliverFillRemaining(
                          child: StaggeredAnimatedList(
                        phyics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Enter volunteer email',
                                style: textTheme.subhead.copyWith(color: textTheme.body1.color),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailEditingController,
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: InputValidators.email,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppButton(
                              onPressed: () => _add(bloc),
                              child: Text(
                                'ADD VOLUNTEER'.toUpperCase(),
                                style: textTheme.button.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //     height: MediaQuery.of(context).viewInsets.bottom + kToolbarHeight + kToolbarHeight,
                          //     child: SizedBox()),
                        ],
                      ));
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

  _add(AddVolunteersBloc bloc) async {
    final textTheme = Theme.of(context).textTheme;
    if (_formKey.currentState.validate()) {
      final bool exit = await showBluredModal<bool>(context,
          height: MediaQuery.of(context).size.height,
          blur: true,
          barrierDismissble: false,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: BlocBuilder<AddVolunteersBloc, AddVolunteersState>(
              bloc: bloc,
              builder: (context, state) {
                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppBorderRadius.medium_all,
                            ),
                            child: AnimatedSwitcher(
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeIn,
                              duration: Duration(milliseconds: 400),
                              child: state is AddedState
                                  ? SizedBox(
                                      child: StaggeredAnimatedColumn(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        duration: Duration(milliseconds: 700),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'VOLUNTEER ADDED',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title
                                                  .copyWith(fontWeight: FontWeight.w700, color: AppColors.success),
                                            ),
                                          ),
                                          Divider(height: 16),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: 'You have successfully added',
                                                    children: [
                                                      TextSpan(
                                                        text: ' ${emailEditingController.value.text} ',
                                                        style: TextStyle(fontWeight: FontWeight.w900),
                                                      ),
                                                      TextSpan(
                                                        text: 'as a volunteer!',
                                                      ),
                                                    ],
                                                    style: Theme.of(context).textTheme.subhead,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8).copyWith(top: 8),
                                                  child: SizedBox(
                                                    child: AppButton(
                                                      boxShadow: [],
                                                      loading: state is LoadingState,
                                                      onPressed: () {
                                                        if (state is AddedState) {
                                                          emailEditingController.clear();
                                                          bloc.add(Reset());
                                                        }
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      child: Text(
                                                        'ADD MORE'.toUpperCase(),
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: SizedBox(
                                                    child: AppButton.white(
                                                      boxShadow: [],
                                                      loading: state is LoadingState,
                                                      onPressed: () {
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      child: Text(
                                                        'DONE'.toUpperCase(),
                                                        style: TextStyle(color: AppColors.secondary),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  : _PasswordForm(
                                      bloc: bloc,
                                      email: emailEditingController.value.text,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(.3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ]),
                            child: IconButton(
                              color: AppColors.primary,
                              onPressed: () {
                                if (state is AddedState) {
                                  emailEditingController.clear();
                                  bloc.add(Reset());
                                }
                                Navigator.of(context).pop(false);
                              },
                              icon: Icon(Icons.close, color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }));
      if (exit) {
        Navigator.of(context).pop();
      }
    }
  }
}

class _PasswordForm extends StatefulWidget {
  const _PasswordForm({
    Key key,
    @required this.bloc,
    @required this.email,
  }) : super(key: key);

  final AddVolunteersBloc bloc;
  final String email;

  @override
  __PasswordFormState createState() => __PasswordFormState();
}

class __PasswordFormState extends State<_PasswordForm> {
  final GlobalKey<FormState> _confirmKey = GlobalKey<FormState>();
  TextEditingController passwordEditingController;
  @override
  void initState() {
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _confirmKey,
      child: BlocListener<AddVolunteersBloc, AddVolunteersState>(
        bloc: widget.bloc,
        listener: (context, state) {
          FocusScope.of(context).requestFocus();
        },
        child: BlocBuilder<AddVolunteersBloc, AddVolunteersState>(
            bloc: widget.bloc,
            builder: (context, state) {
              return StaggeredAnimatedColumn(
                duration: Duration(milliseconds: 700),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Divider(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: RichText(
                              text: TextSpan(
                            text: 'Please confirm your password to add this email:',
                            children: [
                              TextSpan(
                                text: ' ${widget.email}?',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ],
                            style: Theme.of(context).textTheme.subhead,
                          )),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: true,
                          // enabled: state is! LoadingState,
                          onChanged: (value) => widget.bloc.add(Reset()),
                          controller: passwordEditingController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: InputValidators.minLength,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      if (state is LoadingState)
                        Positioned.fill(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: SizedBox.expand(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white70),
                            ),
                          ),
                        )
                    ],
                  ),
                  AnimatedContainer(
                    margin: EdgeInsets.symmetric(vertical: state is ErrorState ? 4 : 0, horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: state is ErrorState ? null : 0,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: AppColors.error, width: 4)),
                      color: AppColors.error.withOpacity(.1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 16),
                        if (state is ErrorState)
                          Text(
                            state?.error ?? 'Error adding volunteer',
                            style: textTheme.caption.copyWith(
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      loading: state is LoadingState,
                      onPressed: () {
                        if (_confirmKey.currentState.validate()) {
                          final organizer = BlocProvider.of<AppBloc>(context).state.currentUser;
                          widget.bloc.add(AddVolunteer(
                            volunteerEmail: widget.email,
                            organizerEmail: organizer.email,
                            organizerPassword: passwordEditingController.value.text,
                            apiURL: organizer.apiURL,
                          ));
                        }
                      },
                      child: Text(
                        'CONFIRM'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

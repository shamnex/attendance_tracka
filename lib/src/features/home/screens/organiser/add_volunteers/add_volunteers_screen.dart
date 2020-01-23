import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_app_bar.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
import 'package:attendance_tracka/src/widgets/staggered_animated_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddVolunteersScreen extends StatefulWidget {
  const AddVolunteersScreen({Key key}) : super(key: key);

  @override
  _AddVolunteersScreenState createState() => _AddVolunteersScreenState();
}

class _AddVolunteersScreenState extends State<AddVolunteersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignupBloc signupBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            AuthScreenScaffold(
                lightBG: true,
                appBar: AuthAppBar(
                  maxHeight: 200,
                  minHeight: kToolbarHeight,
                  lightBG: true,
                  title: 'Add Volunteers',
                ),
                title: 'Add Volunteers',
                builder: (appMode) {
                  return SliverFillRemaining(
                      child: StaggeredAnimatedList(
                    phyics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          text: 'Enter emails of volunteer',
                          style: textTheme.subhead.copyWith(color: textTheme.body1.color),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => signupBloc.add(EmailChanged(value)),
                        validator: InputValidators.email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        onPressed: _add,
                        child: Text(
                          'ADD VOLUNTEER'.toUpperCase(),
                          style: textTheme.button.copyWith(color: Colors.white),
                        ),
                      ),
                      // SizedBox(
                      //     height: MediaQuery.of(context).viewInsets.bottom + kToolbarHeight + kToolbarHeight,
                      //     child: SizedBox()),
                    ],
                  ));
                }),
          ],
        ));
  }

  _add() {
    if (_formKey.currentState.validate()) {
      final userType =
          BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer ? UserType.organizer : UserType.volunteer;
    }
  }
}

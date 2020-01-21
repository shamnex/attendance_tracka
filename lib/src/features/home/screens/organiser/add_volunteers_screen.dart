import 'package:attendance_tracka/src/constants/colors.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/auth/screens/partials/auth_screen_scaffold.dart';
import 'package:attendance_tracka/src/features/auth/screens/signup/bloc/bloc.dart';
import 'package:attendance_tracka/src/utils/input_validators.dart';
import 'package:attendance_tracka/src/widgets/buttons.dart';
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
    List<String> volunteers = [];

    return Form(
        key: _formKey,
        child: AuthScreenScaffold(
            title: 'Add Volunteers',
            builder: (appMode) {
              final bool isVolunteer = appMode == AppMode.volunteer;
              final Color modeColor = isVolunteer ? textTheme.body1.color : Colors.white;

              return <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Enter Emails of Volunteers',
                    style: textTheme.subhead.copyWith(color: isVolunteer ? textTheme.body1.color : Colors.white),
                  ),
                ),
                SizedBox(height: 30),
                ...List.generate(volunteers.length + 1, (index) {
                  return Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => signupBloc.add(EmailChanged(value)),
                        validator: InputValidators.email,
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
                      SizedBox(height: 16)
                    ],
                  );
                }),
                AppIconButton(
                  shadow: false,
                  backgroundColor: Colors.transparent,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                AppButton.white(
                  onPressed: _signup,
                  child: Text(
                    'ADD VOLUNTEERS'.toUpperCase(),
                    style: textTheme.button.copyWith(color: isVolunteer ? Colors.white : textTheme.body1.color),
                  ),
                ),
                SizedBox(height: 8),
              ];
            }));
  }

  _signup() {
    if (_formKey.currentState.validate()) {
      final userType =
          BlocProvider.of<AppBloc>(context).state.mode == AppMode.organizer ? UserType.organizer : UserType.volunteer;
      signupBloc.add(SignUp(userType));
    }
  }
}

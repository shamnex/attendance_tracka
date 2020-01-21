import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrganizerSignupEvent extends Equatable {
  const OrganizerSignupEvent();
  List<Object> get props => [];
}

class PasswordChanged extends OrganizerSignupEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ApiChanged extends OrganizerSignupEvent {
  final String apiURL;
  ApiChanged(this.apiURL);

  @override
  List<Object> get props => [apiURL];
}

class UserNameChanged extends OrganizerSignupEvent {
  final String userName;
  UserNameChanged(this.userName);

  @override
  List<Object> get props => [userName];
}

class EmailChanged extends OrganizerSignupEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class OrganizationChanged extends OrganizerSignupEvent {
  final String organization;
  OrganizationChanged(this.organization);

  @override
  List<Object> get props => [organization];
}

class SignUp extends OrganizerSignupEvent {
  final UserType userType;

  SignUp(this.userType);
  @override
  List<Object> get props => [userType];
}

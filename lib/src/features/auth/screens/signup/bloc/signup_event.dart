import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class PasswordChanged extends SignupEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ApiChanged extends SignupEvent {
  final String apiURL;
  ApiChanged(this.apiURL);

  @override
  List<Object> get props => [apiURL];
}

class UserNameChanged extends SignupEvent {
  final String userName;
  UserNameChanged(this.userName);

  @override
  List<Object> get props => [userName];
}

class EmailChanged extends SignupEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class OrganizationChanged extends SignupEvent {
  final String organization;
  OrganizationChanged(this.organization);

  @override
  List<Object> get props => [organization];
}

class SignUp extends SignupEvent {
  final UserType userType;

  SignUp(this.userType);
  @override
  List<Object> get props => [userType];
}

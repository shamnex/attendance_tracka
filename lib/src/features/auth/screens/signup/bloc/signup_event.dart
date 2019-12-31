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
  @override
  List<Object> get props => [];
}

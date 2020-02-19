import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class UserNameChanged extends LoginEvent {
  final String username;
  UserNameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class ApiChanged extends LoginEvent {
  final String apiURL;
  ApiChanged(this.apiURL);
  @override
  List<Object> get props => [apiURL];
}

class OrganizerLogin extends LoginEvent {}

class VolunteerLogin extends LoginEvent {
  VolunteerLogin({this.haspassword});
  final bool haspassword;
}

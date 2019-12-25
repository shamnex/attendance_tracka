import 'package:attendance_tracka/src/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
}

class BeginAuthentication extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Deauthenticate extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Authenticate extends AuthEvent {
  Authenticate({this.token, this.user});
  final String token;
  final User user;
  @override
  List<Object> get props => [user, token];
}

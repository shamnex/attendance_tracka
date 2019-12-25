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
  Authenticate({this.token});
  final String token;
  @override
  List<Object> get props => [token];
}

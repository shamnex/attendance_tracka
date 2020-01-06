import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
}

class BeginAuthentication extends AuthEvent {
  @override
  List<Object> get props => ['BeginAuthentication'];
}

class Deauthenticate extends AuthEvent {
  @override
  List<Object> get props => ['Deauthenticate'];
}

class Authenticate extends AuthEvent {
  @override
  List<Object> get props => ['Authenticate'];
}

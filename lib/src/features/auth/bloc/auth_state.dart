import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => ['AuthLoading'];
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => ['AuthInitialState'];
}

class AuthAuthenticated extends AuthState {
  @override
  List<Object> get props => ['AuthAuthenticated'];
}

class AuthUnAuthenticated extends AuthState {
  @override
  List<Object> get props => ['AuthUnAuthenticated'];
}

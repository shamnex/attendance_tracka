import 'package:attendance_tracka/src/model/user_model.dart';
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
  final User user;
  AuthAuthenticated(this.user);
  @override
  List<Object> get props => [user];
}

class AuthTokenExpired extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUnAuthenticated extends AuthState {
  @override
  List<Object> get props => ['AuthUnAuthenticated'];
}

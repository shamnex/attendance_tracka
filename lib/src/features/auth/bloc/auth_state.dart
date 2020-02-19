import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnAuthenticated extends AuthState {
  @override
  List<Object> get props => ['AuthUnAuthenticated'];
}

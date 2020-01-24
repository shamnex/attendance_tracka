import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
  @override
  List<Object> get props => [];
}

class BeginAuthentication extends AuthEvent {}

class Deauthenticate extends AuthEvent {}

class Authenticate extends AuthEvent {}

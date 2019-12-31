import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();
}

class InitialLoginBlocState extends LoginBlocState {
  @override
  List<Object> get props => [];
}

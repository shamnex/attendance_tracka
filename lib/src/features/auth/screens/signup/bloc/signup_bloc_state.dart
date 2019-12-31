import 'package:equatable/equatable.dart';

abstract class SignupBlocState extends Equatable {
  const SignupBlocState();
}

class InitialSignupBlocState extends SignupBlocState {
  @override
  List<Object> get props => [];
}

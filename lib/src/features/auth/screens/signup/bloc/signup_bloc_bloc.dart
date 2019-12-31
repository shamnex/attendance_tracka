import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SignupBlocBloc extends Bloc<SignupBlocEvent, SignupBlocState> {
  @override
  SignupBlocState get initialState => InitialSignupBlocState();

  @override
  Stream<SignupBlocState> mapEventToState(
    SignupBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

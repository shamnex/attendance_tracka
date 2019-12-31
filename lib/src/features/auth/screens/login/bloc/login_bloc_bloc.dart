import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(
    LoginBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

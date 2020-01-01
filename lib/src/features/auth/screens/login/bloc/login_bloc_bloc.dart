import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../auth_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final AuthRepository repo;
  LoginBloc(this.repo);
  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(
    LoginBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

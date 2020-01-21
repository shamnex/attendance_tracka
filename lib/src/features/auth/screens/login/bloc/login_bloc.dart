import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with DioErrorHelper {
  final AuthRepository repo;
  LoginBloc(this.repo);
  @override
  LoginState get initialState => LoginState.initialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is PasswordChanged) {
        yield state.rebuild((b) => b
          ..password = event.password
          ..errorMessage = '');
      }
      if (event is EmailChanged) {
        yield state.rebuild((b) => b
          ..email = event.email
          ..errorMessage = '');
      }

      if (event is Login) {
        yield state.rebuild((b) => b
          ..loading = true
          ..errorMessage = '');
        final user = await repo.login(
          email: state.email,
          password: state.password,
          userType: event.userType,
        );
        yield state.rebuild((b) => b
          ..loading = false
          ..errorMessage = ''
          ..user = user.toBuilder());
      }
    } on DioError catch (e) {
      yield state.rebuild((b) => b
        ..loading = false
        ..errorMessage = handleNetworkError(e));
    } catch (e) {
      //TODO CRASHYLITICS??
      yield state.rebuild(
        (b) => b..loading = false,
      );
    }
  }
}

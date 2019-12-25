import 'package:attendance_tracka/src/core/network/http_error_handler.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with DioErrorHelper {
  final AuthRepository repository;
  AuthBloc(this.repository);
  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is BeginAuthentication) {
        yield AuthLoading();
        await Future.delayed(Duration(milliseconds: 400));
        final hasToken = await repository.hasToken();
        if (hasToken) {
          yield AuthAuthenticated();
        } else {
          yield AuthUnAuthenticated();
        }
      }

      if (event is Authenticate) {
        yield AuthLoading();
        await repository.persistToken(event.token);
        yield AuthAuthenticated();
      }

      if (event is Deauthenticate) {
        yield AuthLoading();
        await Future.delayed(const Duration(milliseconds: 300));
        await repository.deleteToken();
        yield AuthUnAuthenticated();
      }
    } on DioError catch (_) {
      yield AuthLoading();
      await Future.delayed(const Duration(milliseconds: 200));
      yield state;
    } catch (e) {
      yield AuthLoading();
      await Future.delayed(const Duration(milliseconds: 200));
      yield state;
    }
  }
}

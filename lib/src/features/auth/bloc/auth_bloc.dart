import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_event.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with DioErrorHelper {
  final AuthRepository repository;
  final AppBloc appBloc;
  AuthBloc(this.repository, this.appBloc) {
    appBloc.listen((appState) {
      if (appState.userLoggedIn) {
        add(Authenticate());
      }
    });
  }
  @override
  AuthState get initialState => appBloc.state.userLoggedIn ? AuthAuthenticated() : AuthUnAuthenticated();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is BeginAuthentication) {
        yield AuthLoading();
        if (appBloc.state.userLoggedIn) {
          yield AuthAuthenticated();
        } else {
          yield AuthUnAuthenticated();
        }
      }
      if (event is Authenticate) {
        yield AuthLoading();
        await Future.delayed(const Duration(milliseconds: 1000));
        yield AuthAuthenticated();
      }
      if (event is Deauthenticate) {
        yield AuthLoading();
        appBloc.add(UserLoggedOut());
        await Future.delayed(const Duration(milliseconds: 1000));
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

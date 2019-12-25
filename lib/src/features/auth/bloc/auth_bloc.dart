import 'package:attendance_tracka/src/blocs/user/bloc/user_bloc.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:attendance_tracka/src/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with DioErrorHandle {
  final AuthRepository repository;
  User _user;
  AuthBloc(this.repository) {
    this.userBloc.listen((state) {
      _user = state.value;
    });
  }
  final UserBloc userBloc;

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is BeginAuthentication) {
        yield AuthLoading();
        //DELAY TO GET USER FROM CACHE
        await Future.delayed(Duration(milliseconds: 500));
        final hasToken = await repository.hasToken();
        if (hasToken) {
          if (userBloc.state.hasValue) {
            yield AuthAuthenticated(_user);
            //NEDED TO REBUILD DATA FROM CACHE
            userBloc.add(UpdateBaseBloc<User>(value: userBloc.state.value));
          } else {
            _user = await userBloc.repository.getProfile();
            userBloc.update(value: _user);
            yield AuthAuthenticated(_user);
          }
        } else {
          yield AuthUnAuthenticated();
        }
      }

      if (event is Authenticate) {
        yield AuthLoading();
        if (event.user is User) {
          if (!await repository.hasToken() && event.token is String) {
            await repository.persistToken(event.token);
          } else {
            yield AuthUnAuthenticated();
          }
          _user = await userBloc.repository.getProfile();
          userBloc.add(UpdateBaseBloc<User>(value: _user, loading: false));
          yield AuthAuthenticated(_user);
        } else {
          yield AuthUnAuthenticated();
        }
      }

      if (event is Deauthenticate) {
        yield AuthLoading();
        await Future.delayed(const Duration(milliseconds: 300));
        _user = null;
        await repository.deleteToken();
        await userBloc.update(value: null);
        await userBloc.clear();
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

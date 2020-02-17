import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:attendance_tracka/src/features/auth/screens/login/model/volunteer_login_success.dart';
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
      if (event is UserNameChanged) {
        yield state.rebuild((b) => b
          ..username = event.username
          ..errorMessage = '');
      }
      if (event is ApiChanged) {
        yield state.rebuild((b) => b
          ..apiURL = event.apiURL
          ..errorMessage = '');
      }

      if (event is VolunteerLogin) {
        yield state.rebuild((b) => b
          ..loading = true
          ..errorMessage = '');

        if (!event.haspassword) {
          await repo.createVolunteerPassword(
            email: state.email,
            password: state.password,
            organisationApiURL: state.apiURL,
          );
        }

        final VolunteerLoginSuccess success = await repo.volunteerLogin(
          email: state.email,
          password: state.password,
          apiURL: state.apiURL,
          organisationUserName: state.username,
        );

        yield state.rebuild((b) => b
          ..loading = false
          ..errorMessage = ''
          ..iteration = success.iteration
          ..user = success.user.toBuilder());
      }
      if (event is OrganizerLogin) {
        yield state.rebuild((b) => b
          ..loading = true
          ..errorMessage = '');
        final user = await repo.organizerLogin(
          email: state.email,
          password: state.password,
        );

        yield state.rebuild((b) => b
          ..loading = false
          ..errorMessage = ''
          ..user = user.toBuilder());
      }
    } on DioError catch (e) {
      yield state.rebuild((b) => b
        ..loading = false
        ..errorMessage = handleDioError(e));
    } catch (e) {
      //!CRASHYLITICS??
      print(e.toString());
      yield state.rebuild(
        (b) => b..loading = false,
      );
    }
  }
}

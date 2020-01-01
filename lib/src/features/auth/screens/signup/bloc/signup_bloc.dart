import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> with DioErrorHelper {
  final AuthRepository repo;
  SignupBloc(this.repo);
  @override
  SignupState get initialState => SignupState.initialState();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is PasswordChanged) {
      yield state.rebuild((b) => b..password = event.password);
    }
    if (event is EmailChanged) {
      yield state.rebuild((b) => b..email = event.email);
    }
    if (event is OrganizationChanged) {
      yield state.rebuild((b) => b..organization = event.organization);
    }
    if (event is SignUp) {
      try {
        yield state.rebuild((b) => b..loading = true);
        await Future.delayed(Duration(seconds: 1));
        final user = await repo.signup();
        yield state.rebuild(
          (b) => b
            ..loading = false
            ..user = user.toBuilder(),
        );
      } on DioError catch (e) {
        yield state.rebuild((b) => b
          ..loading = false
          ..errorMessage = handleNetworkError(e));
      } catch (e) {
        throw Exception();
      }
    }
  }
}
